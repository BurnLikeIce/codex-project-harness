#!/usr/bin/env bash
set -euo pipefail

PROJECT_PATH="${1:-$(pwd)}"
PROJECT_ROOT="$(cd "$PROJECT_PATH" && pwd)"

echo "Project: $PROJECT_ROOT"
echo

if [[ -d "$PROJECT_ROOT/.git" ]]; then
  echo "Git: present"
  (
    cd "$PROJECT_ROOT"
    branch="$(git branch --show-current || true)"
    echo "Branch: $branch"

    remote="$(git remote -v || true)"
    if [[ -n "$remote" ]]; then
      echo "Remote:"
      echo "$remote" | sed 's/^/  /'
    else
      echo "Remote: none"
    fi

    status="$(git status --short || true)"
    if [[ -n "$status" ]]; then
      echo "Working tree:"
      echo "$status" | sed 's/^/  /'
    else
      echo "Working tree: clean"
    fi
  )
else
  echo "Git: missing"
fi

echo
echo "Harness files:"

required=(
  "HARNESS.md"
  "docs/sop.md"
  "docs/product.md"
  "docs/architecture.md"
  "docs/api-contract.md"
  "docs/tasks.md"
  "docs/intent.md"
  "docs/migration.md"
  "docs/dispatch.md"
  "docs/triage.md"
  "docs/completion.md"
  "docs/acceptance.md"
  "docs/decisions.md"
  "docs/changelog.md"
  "prompts/master.md"
  "prompts/product.md"
  "prompts/frontend.md"
  "prompts/backend.md"
  ".github/pull_request_template.md"
)

for item in "${required[@]}"; do
  if [[ -e "$PROJECT_ROOT/$item" ]]; then
    echo "OK   $item"
  else
    echo "MISS $item"
  fi
done
