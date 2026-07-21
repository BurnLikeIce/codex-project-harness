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

[ -f "$project_path/docs/tasks.md" ] || printf 'WARNING: docs/tasks.md is absent; HARNESS.md must map an equivalent source.\n' >&2
[ -f "$project_path/docs/decisions.md" ] || printf 'WARNING: docs/decisions.md is absent; HARNESS.md must map an equivalent source.\n' >&2

if [ "$errors" -ne 0 ]; then exit 1; fi
printf 'VALID: Project Harness managed structure at %s\n' "$project_path"
