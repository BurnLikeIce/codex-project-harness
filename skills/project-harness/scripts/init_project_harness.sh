#!/usr/bin/env bash
set -euo pipefail

PROJECT_PATH="${1:-$(pwd)}"
FORCE="${FORCE:-0}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_ROOT="$SKILL_ROOT/assets/project-template"
PROJECT_ROOT="$(cd "$PROJECT_PATH" && pwd)"

if [[ ! -d "$TEMPLATE_ROOT" ]]; then
  echo "Template root not found: $TEMPLATE_ROOT" >&2
  exit 1
fi

while IFS= read -r -d '' source_file; do
  relative_path="${source_file#$TEMPLATE_ROOT/}"
  destination="$PROJECT_ROOT/$relative_path"
  destination_dir="$(dirname "$destination")"
  mkdir -p "$destination_dir"

  if [[ -e "$destination" && "$FORCE" != "1" ]]; then
    echo "SKIP existing: $destination"
    continue
  fi

  cp "$source_file" "$destination"
  echo "COPY: $destination"
done < <(find "$TEMPLATE_ROOT" -type f -print0)

echo
echo "Project harness installed at: $PROJECT_ROOT"
echo "Next: use prompts/master.md in this conversation. Default to single-conversation harness mode; create specialist conversations only when useful."
