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
copy_missing docs/tasks.md
copy_missing docs/decisions.md

block_file="$project_path/.project-harness-entry.tmp"
if [ "$language" = "zh-CN" ]; then
  heading='# 智能体说明'
  cat > "$block_file" <<'EOF'
<!-- project-harness:entry:start -->
在修改长期项目状态、任务、决策、协调、验收或发布边界之前，先阅读 `HARNESS.md`。使用当前安装的 Project Harness 规则，并保留项目已有的事实来源。
<!-- project-harness:entry:end -->
EOF
else
  heading='# Agent Instructions'
  cat > "$block_file" <<'EOF'
<!-- project-harness:entry:start -->
Read `HARNESS.md` before changing durable project state, tasks, decisions, coordination, acceptance, or release boundaries. Use the currently installed Project Harness rules and preserve existing project sources of truth.
<!-- project-harness:entry:end -->
EOF
fi

replace_managed_block "$project_path/AGENTS.md" "$heading" "$block_file"
rm -f "$block_file"
printf 'Project Harness 2 initialized at: %s\n' "$project_path"
