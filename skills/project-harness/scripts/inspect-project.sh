#!/usr/bin/env sh
set -eu

project_path="${1:-.}"
project_path=$(cd "$project_path" && pwd)

first_existing() {
  for candidate in "$@"; do
    if [ -f "$project_path/$candidate" ]; then
      printf '%s' "$candidate"
      return 0
    fi
  done
  printf '%s' ""
}

tasks=$(first_existing docs/tasks.md TASKS.md docs/task.md)
decisions=$(first_existing docs/decisions.md DECISIONS.md docs/decision-log.md)
product=$(first_existing docs/product.md docs/prd.md PRD.md docs/product-spec.md)
architecture=$(first_existing docs/architecture.md ARCHITECTURE.md docs/design.md)
api=$(first_existing docs/api-contract.md docs/api.md API.md openapi.yaml openapi.yml)
acceptance=$(first_existing docs/acceptance.md docs/testing.md TESTING.md)
handoff=$(first_existing docs/handovers/current-control-state.md docs/handoff.md HANDOFF.md)

protocol="unversioned"
if [ -f "$project_path/HARNESS.md" ] && grep -Eq 'Protocol:[[:space:]]*2|协议版本[：:][[:space:]]*2' "$project_path/HARNESS.md"; then
  protocol="2"
elif [ -f "$project_path/docs/sop.md" ] || [ -f "$project_path/prompts/master.md" ]; then
  protocol="1-compatible"
fi

git_repository="false"
git_branch=""
git_dirty=""
git_remote=""
if command -v git >/dev/null 2>&1 && git -C "$project_path" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git_repository="true"
  git_branch=$(git -C "$project_path" branch --show-current 2>/dev/null || true)
  git_dirty=$(git -C "$project_path" status --porcelain 2>/dev/null || true)
  git_remote=$(git -C "$project_path" remote get-url origin 2>/dev/null || true)
fi

cat <<EOF
project_path=$project_path
protocol=$protocol
tasks=$tasks
decisions=$decisions
product=$product
architecture=$architecture
api=$api
acceptance=$acceptance
handoff=$handoff
git_repository=$git_repository
git_branch=$git_branch
git_dirty=$([ -n "$git_dirty" ] && printf true || printf false)
git_remote=$git_remote
EOF
