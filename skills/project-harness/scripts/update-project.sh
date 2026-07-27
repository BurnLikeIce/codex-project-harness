#!/usr/bin/env sh
set -eu

project_path="."
language="en"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --project-path) project_path="$2"; shift 2 ;;
    --language) language="$2"; shift 2 ;;
    *) printf 'Unknown argument: %s\n' "$1" >&2; exit 2 ;;
  esac
done

case "$language" in en|zh-CN) ;; *) printf 'Language must be en or zh-CN\n' >&2; exit 2 ;; esac
project_path=$(cd "$project_path" && pwd)

mapped_existing() {
  pattern="$1"
  [ -f "$project_path/HARNESS.md" ] || return 1
  managed=$(awk '
    /<!-- project-harness:managed:start -->/ { active = 1; next }
    /<!-- project-harness:managed:end -->/ { active = 0 }
    active { print }
  ' "$project_path/HARNESS.md")
  line=$(printf '%s\n' "$managed" | grep -E "$pattern" | head -n 1 || true)
  [ -n "$line" ] || return 1
  value=$(printf '%s\n' "$line" | sed -E 's/^[[:space:]]*-[[:space:]]*[^:：]+[:：][[:space:]]*//; s/^`//; s/`$//')
  [ "$value" != "(not mapped)" ] || return 1
  case "$value" in
    /*) mapped_path="$value" ;;
    *) mapped_path="$project_path/$value" ;;
  esac
  [ -f "$mapped_path" ] || return 1
  printf '%s' "$value"
}

first_existing() {
  pattern="$1"
  shift
  if mapped=$(mapped_existing "$pattern"); then
    printf '%s' "$mapped"
    return
  fi
  for candidate in "$@"; do
    if [ -f "$project_path/$candidate" ]; then printf '%s' "$candidate"; return; fi
  done
  printf '%s' '(not mapped)'
}

tasks=$(first_existing '^[[:space:]]*-[[:space:]]*(Tasks|任务记录)[：:]' docs/tasks.md TASKS.md docs/task.md)
decisions=$(first_existing '^[[:space:]]*-[[:space:]]*(Decisions|决策记录)[：:]' docs/decisions.md DECISIONS.md docs/decision-log.md)
product=$(first_existing '^[[:space:]]*-[[:space:]]*(Product|产品事实)[：:]' docs/product.md docs/prd.md PRD.md docs/product-spec.md)
architecture=$(first_existing '^[[:space:]]*-[[:space:]]*(Architecture|架构事实)[：:]' docs/architecture.md ARCHITECTURE.md docs/design.md)
api=$(first_existing '^[[:space:]]*-[[:space:]]*(API|API 契约)[：:]' docs/api-contract.md docs/api.md API.md openapi.yaml openapi.yml)
acceptance=$(first_existing '^[[:space:]]*-[[:space:]]*(Acceptance|验收依据)[：:]' docs/acceptance.md docs/testing.md TESTING.md)
handoff=$(first_existing '^[[:space:]]*-[[:space:]]*(Handoff|主控交接)[：:]' docs/handovers/current-control-state.md docs/handoff.md HANDOFF.md)

replace_managed_block() {
  path="$1"
  heading="$2"
  start="$3"
  end="$4"
  block_file="$5"
  [ -f "$path" ] || printf '%s\n' "$heading" > "$path"
  output="$path.project-harness.tmp"

  if grep -Fq "$start" "$path"; then
    awk -v start="$start" -v end="$end" -v block_file="$block_file" '
      BEGIN { while ((getline line < block_file) > 0) block = block line ORS; close(block_file) }
      index($0, start) { printf "%s", block; managed = 1; next }
      managed && index($0, end) { managed = 0; next }
      !managed { print }
    ' "$path" > "$output"
  else
    cp "$path" "$output"
    printf '\n' >> "$output"
    cat "$block_file" >> "$output"
  fi

  if cmp -s "$path" "$output"; then
    rm -f "$output"
    printf 'UNCHANGED: %s\n' "$(basename "$path")"
  else
    mv "$output" "$path"
    printf 'UPDATE: %s\n' "$(basename "$path")"
  fi
}

harness_block="$project_path/.project-harness-managed.tmp"
agents_block="$project_path/.project-harness-entry.tmp"

if [ "$language" = "zh-CN" ]; then
  cat > "$harness_block" <<EOF
<!-- project-harness:managed:start -->
## Harness 协议

- 协议版本：2
- 存储方式：保留当前项目结构和已映射的事实来源。
- 任务记录：\`$tasks\`
- 决策记录：\`$decisions\`
- 产品事实：\`$product\`
- 架构事实：\`$architecture\`
- API 契约：\`$api\`
- 验收依据：\`$acceptance\`
- 主控交接：\`$handoff\`
- 工作规则：保留所有项目专属事实和自定义文档；通用工作流程使用当前安装的 Project Harness 协议。
<!-- project-harness:managed:end -->
EOF
  cat > "$agents_block" <<'EOF'
<!-- project-harness:entry:start -->
项目工作可能影响需求、任务、决策、缺陷、验收、进度、协调、交接或发布边界时，自动使用当前安装的 Project Harness 规则，并在修改长期状态前阅读 `HARNESS.md`。根据日常表达判断项目意图，不要求用户说出 Skill 名称或理解主控等内部术语。保留已映射的事实来源；在用户明确开始、继续或批准执行之前，探索性讨论保持只读。
<!-- project-harness:entry:end -->
EOF
  harness_heading='# Project Harness'
  agents_heading='# 智能体说明'
else
  cat > "$harness_block" <<EOF
<!-- project-harness:managed:start -->
## Harness Protocol

- Protocol: 2
- Storage: preserve the current project layout and mapped sources of truth.
- Tasks: \`$tasks\`
- Decisions: \`$decisions\`
- Product: \`$product\`
- Architecture: \`$architecture\`
- API: \`$api\`
- Acceptance: \`$acceptance\`
- Handoff: \`$handoff\`
- Working rule: preserve project-specific facts and customized documents; use the currently installed Project Harness protocol for generic workflow behavior.
<!-- project-harness:managed:end -->
EOF
  cat > "$agents_block" <<'EOF'
<!-- project-harness:entry:start -->
For project work that may affect requirements, tasks, decisions, defects, acceptance, progress, coordination, handoff, or release boundaries, use the currently installed Project Harness rules and read `HARNESS.md` before changing durable state. Infer project intent from ordinary language; do not require the user to name the skill or understand control-context terminology. Preserve mapped sources of truth, and keep exploratory discussion read-only until the user clearly starts, resumes, or approves execution.
<!-- project-harness:entry:end -->
EOF
  harness_heading='# Project Harness'
  agents_heading='# Agent Instructions'
fi

replace_managed_block "$project_path/HARNESS.md" "$harness_heading" '<!-- project-harness:managed:start -->' '<!-- project-harness:managed:end -->' "$harness_block"
replace_managed_block "$project_path/AGENTS.md" "$agents_heading" '<!-- project-harness:entry:start -->' '<!-- project-harness:entry:end -->' "$agents_block"
rm -f "$harness_block" "$agents_block"

printf 'Project Harness protocol updated in place at: %s\n' "$project_path"
printf 'No existing project documents were moved, deleted, or rewritten outside managed blocks.\n'
