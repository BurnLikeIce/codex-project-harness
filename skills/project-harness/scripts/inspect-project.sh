#!/usr/bin/env sh
set -eu

project_path="${1:-.}"
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
    return 0
  fi
  for candidate in "$@"; do
    if [ -f "$project_path/$candidate" ]; then
      printf '%s' "$candidate"
      return 0
    fi
  done
  printf '%s' ""
}

tasks=$(first_existing '^[[:space:]]*-[[:space:]]*(Tasks|任务记录)[：:]' docs/tasks.md TASKS.md docs/task.md)
decisions=$(first_existing '^[[:space:]]*-[[:space:]]*(Decisions|决策记录)[：:]' docs/decisions.md DECISIONS.md docs/decision-log.md)
product=$(first_existing '^[[:space:]]*-[[:space:]]*(Product|产品事实)[：:]' docs/product.md docs/prd.md PRD.md docs/product-spec.md)
architecture=$(first_existing '^[[:space:]]*-[[:space:]]*(Architecture|架构事实)[：:]' docs/architecture.md ARCHITECTURE.md docs/design.md)
api=$(first_existing '^[[:space:]]*-[[:space:]]*(API|API 契约)[：:]' docs/api-contract.md docs/api.md API.md openapi.yaml openapi.yml)
acceptance=$(first_existing '^[[:space:]]*-[[:space:]]*(Acceptance|验收依据)[：:]' docs/acceptance.md docs/testing.md TESTING.md)
handoff=$(first_existing '^[[:space:]]*-[[:space:]]*(Handoff|主控交接)[：:]' docs/handovers/current-control-state.md docs/handoff.md HANDOFF.md)

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
