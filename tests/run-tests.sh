#!/usr/bin/env sh
set -eu

tests_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo=$(dirname "$tests_dir")
skill="$repo/skills/project-harness"
temp="$tests_dir/.tmp-tests-sh"

cleanup() {
  case "$temp" in "$repo"/*) rm -rf "$temp" ;; *) printf 'Unsafe test path: %s\n' "$temp" >&2; exit 1 ;; esac
}
trap cleanup EXIT HUP INT TERM

fingerprint() {
  directory="$1"
  find "$directory" -type f -exec cksum {} \; | sort
}

cleanup
mkdir -p "$temp/new-en" "$temp/new-zh" "$temp/v1/docs" "$temp/v1/prompts"

grep -F 'starts or resumes a project' "$skill/SKILL.md" >/dev/null
grep -F 'Do not require the user to name the skill' "$skill/SKILL.md" >/dev/null
grep -F 'Explicitly apply Project Harness' "$skill/SKILL.md" >/dev/null

printf '# Existing Harness\n\nCustom project fact: KEEP-ME\n' > "$temp/v1/HARNESS.md"
printf '# Existing Instructions\n\nCustom rule: KEEP-AGENT\n' > "$temp/v1/AGENTS.md"
printf '# Old tasks\n\nTASK-CONTENT\n' > "$temp/v1/docs/tasks.md"
printf '# Old decisions\n\nDECISION-CONTENT\n' > "$temp/v1/docs/decisions.md"
printf '# Product\n\nPRODUCT-CONTENT\n' > "$temp/v1/docs/product.md"
printf '# Legacy SOP\n\nSOP-CONTENT\n' > "$temp/v1/docs/sop.md"
printf '# Legacy prompt\n\nPROMPT-CONTENT\n' > "$temp/v1/prompts/master.md"

sh "$skill/scripts/init-project.sh" --project-path "$temp/new-en" --language en
sh "$skill/scripts/init-project.sh" --project-path "$temp/new-zh" --language zh-CN

for name in new-en new-zh; do
  count=$(find "$temp/$name" -type f | wc -l | tr -d ' ')
  [ "$count" -eq 4 ] || { printf '%s should contain four files, found %s\n' "$name" "$count" >&2; exit 1; }
  sh "$skill/scripts/validate-project.sh" "$temp/$name"
done

grep -F 'Infer project intent from ordinary language' "$temp/new-en/AGENTS.md" >/dev/null
grep -F '根据日常表达判断项目意图' "$temp/new-zh/AGENTS.md" >/dev/null

sh "$skill/scripts/update-project.sh" --project-path "$temp/v1" --language en
fingerprint "$temp/v1" > "$temp/first.cksum"
sh "$skill/scripts/update-project.sh" --project-path "$temp/v1" --language en
fingerprint "$temp/v1" > "$temp/second.cksum"
cmp -s "$temp/first.cksum" "$temp/second.cksum" || { printf 'V1 update is not idempotent\n' >&2; exit 1; }

sh "$skill/scripts/validate-project.sh" "$temp/v1"
sh "$skill/scripts/inspect-project.sh" "$temp/v1" | grep -F 'protocol=2' >/dev/null
grep -F 'Infer project intent from ordinary language' "$temp/v1/AGENTS.md" >/dev/null

grep -F 'KEEP-ME' "$temp/v1/HARNESS.md" >/dev/null
grep -F 'KEEP-AGENT' "$temp/v1/AGENTS.md" >/dev/null
grep -F 'TASK-CONTENT' "$temp/v1/docs/tasks.md" >/dev/null
grep -F 'DECISION-CONTENT' "$temp/v1/docs/decisions.md" >/dev/null
grep -F 'SOP-CONTENT' "$temp/v1/docs/sop.md" >/dev/null
grep -F 'PROMPT-CONTENT' "$temp/v1/prompts/master.md" >/dev/null

printf 'PASS: Project Harness POSIX shell tests\n'
