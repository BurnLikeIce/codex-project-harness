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

first_existing() {
  for candidate in "$@"; do
    if [ -f "$project_path/$candidate" ]; then printf '%s' "$candidate"; return; fi
  done
  printf '%s' '(not mapped)'
}

tasks=$(first_existing docs/tasks.md TASKS.md docs/task.md)
decisions=$(first_existing docs/decisions.md DECISIONS.md docs/decision-log.md)
product=$(first_existing docs/product.md docs/prd.md PRD.md docs/product-spec.md)
architecture=$(first_existing docs/architecture.md ARCHITECTURE.md docs/design.md)
api=$(first_existing docs/api-contract.md docs/api.md API.md openapi.yaml openapi.yml)
acceptance=$(first_existing docs/acceptance.md docs/testing.md TESTING.md)
handoff=$(first_existing docs/handovers/current-control-state.md docs/handoff.md HANDOFF.md)

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
- 存储方式：兼容当前项目结构，更新不等于迁移。
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
在修改长期项目状态、任务、决策、协调、验收或发布边界之前，先阅读 `HARNESS.md`。使用当前安装的 Project Harness 规则，并保留项目已有的事实来源。
<!-- project-harness:entry:end -->
EOF
  harness_heading='# Project Harness'
  agents_heading='# 智能体说明'
else
  cat > "$harness_block" <<EOF
<!-- project-harness:managed:start -->
## Harness Protocol

- Protocol: 2
- Storage: compatible with the current project layout; update is not migration.
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
Read `HARNESS.md` before changing durable project state, tasks, decisions, coordination, acceptance, or release boundaries. Use the currently installed Project Harness rules and preserve existing project sources of truth.
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
