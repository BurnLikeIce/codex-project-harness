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
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
skill_root=$(dirname "$script_dir")
template_root="$skill_root/assets/minimal-project/$language"

copy_missing() {
  relative="$1"
  destination="$project_path/$relative"
  if [ -e "$destination" ]; then
    printf 'SKIP existing: %s\n' "$relative"
    return
  fi
  mkdir -p "$(dirname "$destination")"
  cp "$template_root/$relative" "$destination"
  printf 'CREATE: %s\n' "$relative"
}

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
    if [ -f "$project_path/$candidate" ]; then
      printf '%s' "$candidate"
      return
    fi
  done
  return 1
}

replace_managed_block() {
  path="$1"
  heading="$2"
  block_file="$3"
  start='<!-- project-harness:entry:start -->'
  end='<!-- project-harness:entry:end -->'
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
    printf 'UNCHANGED: AGENTS.md\n'
  else
    mv "$output" "$path"
    printf 'UPDATE: AGENTS.md\n'
  fi
}

copy_missing HARNESS.md
if task_source=$(first_existing '^[[:space:]]*-[[:space:]]*(Tasks|任务记录)[：:]' docs/tasks.md TASKS.md docs/task.md); then
  printf 'REUSE existing task source: %s\n' "$task_source"
else
  copy_missing docs/tasks.md
fi
if decision_source=$(first_existing '^[[:space:]]*-[[:space:]]*(Decisions|决策记录)[：:]' docs/decisions.md DECISIONS.md docs/decision-log.md); then
  printf 'REUSE existing decision source: %s\n' "$decision_source"
else
  copy_missing docs/decisions.md
fi

block_file="$project_path/.project-harness-entry.tmp"
if [ "$language" = "zh-CN" ]; then
  heading='# 智能体说明'
  cat > "$block_file" <<'EOF'
<!-- project-harness:entry:start -->
项目工作可能影响需求、任务、决策、缺陷、验收、进度、协调、交接或发布边界时，自动使用当前安装的 Project Harness 规则，并在修改长期状态前阅读 `HARNESS.md`。根据日常表达判断项目意图，不要求用户说出 Skill 名称或理解主控等内部术语。保留已映射的事实来源；在用户明确开始、继续或批准执行之前，探索性讨论保持只读。
<!-- project-harness:entry:end -->
EOF
else
  heading='# Agent Instructions'
  cat > "$block_file" <<'EOF'
<!-- project-harness:entry:start -->
For project work that may affect requirements, tasks, decisions, defects, acceptance, progress, coordination, handoff, or release boundaries, use the currently installed Project Harness rules and read `HARNESS.md` before changing durable state. Infer project intent from ordinary language; do not require the user to name the skill or understand control-context terminology. Preserve mapped sources of truth, and keep exploratory discussion read-only until the user clearly starts, resumes, or approves execution.
<!-- project-harness:entry:end -->
EOF
fi

replace_managed_block "$project_path/AGENTS.md" "$heading" "$block_file"
rm -f "$block_file"
sh "$script_dir/update-project.sh" --project-path "$project_path" --language "$language"
sh "$script_dir/validate-project.sh" "$project_path"
printf 'Project Harness 2 initialized or adopted at: %s\n' "$project_path"
