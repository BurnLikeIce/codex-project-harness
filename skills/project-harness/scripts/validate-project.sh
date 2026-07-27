#!/usr/bin/env sh
set -eu

project_path="${1:-.}"
project_path=$(cd "$project_path" && pwd)
errors=0

check_managed_file() {
  relative="$1"
  start="$2"
  end="$3"
  path="$project_path/$relative"

  if [ ! -f "$path" ]; then
    printf 'ERROR: missing %s\n' "$relative" >&2
    errors=$((errors + 1))
    return
  fi

  start_count=$(grep -Fc "$start" "$path" || true)
  end_count=$(grep -Fc "$end" "$path" || true)
  if [ "$start_count" -ne 1 ]; then printf 'ERROR: %s must contain exactly one managed start marker\n' "$relative" >&2; errors=$((errors + 1)); fi
  if [ "$end_count" -ne 1 ]; then printf 'ERROR: %s must contain exactly one managed end marker\n' "$relative" >&2; errors=$((errors + 1)); fi
  if grep -Eq '^(<<<<<<<|=======|>>>>>>>)' "$path"; then printf 'ERROR: %s contains merge conflict markers\n' "$relative" >&2; errors=$((errors + 1)); fi
}

check_managed_file HARNESS.md '<!-- project-harness:managed:start -->' '<!-- project-harness:managed:end -->'
check_managed_file AGENTS.md '<!-- project-harness:entry:start -->' '<!-- project-harness:entry:end -->'

check_mapped_source() {
  label="$1"
  pattern="$2"
  managed=$(awk '
    /<!-- project-harness:managed:start -->/ { active = 1; next }
    /<!-- project-harness:managed:end -->/ { active = 0 }
    active { print }
  ' "$project_path/HARNESS.md")
  line=$(printf '%s\n' "$managed" | grep -E "$pattern" | head -n 1 || true)
  if [ -z "$line" ]; then
    printf 'ERROR: HARNESS.md does not map %s\n' "$label" >&2
    errors=$((errors + 1))
    return
  fi

  value=$(printf '%s\n' "$line" | sed -E 's/^[[:space:]]*-[[:space:]]*[^:：]+[:：][[:space:]]*//; s/^`//; s/`$//')
  if [ "$value" = "(not mapped)" ]; then
    printf 'ERROR: HARNESS.md leaves %s as (not mapped)\n' "$label" >&2
    errors=$((errors + 1))
    return
  fi
  if [ ! -f "$project_path/$value" ]; then
    printf 'ERROR: HARNESS.md maps %s to missing file: %s\n' "$label" "$value" >&2
    errors=$((errors + 1))
  fi
}

check_mapped_source tasks '^[[:space:]]*-[[:space:]]*(Tasks|任务记录)[：:]'
check_mapped_source decisions '^[[:space:]]*-[[:space:]]*(Decisions|决策记录)[：:]'

if [ "$errors" -ne 0 ]; then exit 1; fi
printf 'VALID: Project Harness managed structure at %s\n' "$project_path"
