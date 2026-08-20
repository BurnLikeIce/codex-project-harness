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
mkdir -p "$temp/new-en" "$temp/new-zh" "$temp/v1/docs" "$temp/v1/prompts" "$temp/partial/docs" "$temp/custom/project" "$temp/invalid"

grep -F 'starts or resumes a project' "$skill/SKILL.md" >/dev/null
grep -F 'do not require the skill name or exact commands' "$skill/SKILL.md" >/dev/null
grep -F 'selection alone does not authorize project-file changes' "$skill/SKILL.md" >/dev/null
grep -F 'READY_TO_HANDOFF' "$skill/SKILL.md" >/dev/null
grep -F 'TASK-0001' "$skill/SKILL.md" >/dev/null
grep -F 'project coordinator owns allocation' "$skill/SKILL.md" >/dev/null
grep -F 'inspect relevant task and decision history' "$skill/SKILL.md" >/dev/null
grep -F 'user-visible Codex task only when' "$skill/SKILL.md" >/dev/null
grep -F 'clean, independent task' "$skill/SKILL.md" >/dev/null
grep -F 'HANDOFF_COMPLETE' "$skill/SKILL.md" >/dev/null
grep -F 'Do not create fixed product, frontend, or backend task roles.' "$skill/SKILL.md" >/dev/null

printf '# Existing Harness\n\nCustom project fact: KEEP-ME\n' > "$temp/v1/HARNESS.md"
printf '# Existing Instructions\n\nCustom rule: KEEP-AGENT\n' > "$temp/v1/AGENTS.md"
printf '# Old tasks\n\nTASK-CONTENT\n' > "$temp/v1/docs/tasks.md"
printf '# Old decisions\n\nDECISION-CONTENT\n' > "$temp/v1/docs/decisions.md"
printf '# Product\n\nPRODUCT-CONTENT\n' > "$temp/v1/docs/product.md"
printf '# Legacy SOP\n\nSOP-CONTENT\n' > "$temp/v1/docs/sop.md"
printf '# Legacy prompt\n\nPROMPT-CONTENT\n' > "$temp/v1/prompts/master.md"
printf '# Existing tasks\n\nPARTIAL-TASK-CONTENT\n' > "$temp/partial/TASKS.md"
printf '# Existing product\n\nPARTIAL-PRODUCT-CONTENT\n' > "$temp/partial/docs/product.md"
printf '# Custom tasks\n\nCUSTOM-TASK-CONTENT\n' > "$temp/custom/project/work-items.md"
printf '# Custom decisions\n\nCUSTOM-DECISION-CONTENT\n' > "$temp/custom/project/choices.md"
cat > "$temp/custom/HARNESS.md" <<'EOF'
# Existing Harness

<!-- project-harness:managed:start -->
## Harness Protocol

- Protocol: 2
- Tasks: `project/work-items.md`
- Decisions: `project/choices.md`
<!-- project-harness:managed:end -->
EOF

sh "$skill/scripts/init-project.sh" --project-path "$temp/new-en" --language en
sh "$skill/scripts/init-project.sh" --project-path "$temp/new-zh" --language zh-CN

for name in new-en new-zh; do
  count=$(find "$temp/$name" -type f | wc -l | tr -d ' ')
  [ "$count" -eq 4 ] || { printf '%s should contain four files, found %s\n' "$name" "$count" >&2; exit 1; }
  sh "$skill/scripts/validate-project.sh" "$temp/$name"
  grep -F 'TASK-0001' "$temp/$name/docs/tasks.md" >/dev/null
  grep -F 'DEC-0001' "$temp/$name/docs/decisions.md" >/dev/null
done

grep -F 'Infer project intent from ordinary language' "$temp/new-en/AGENTS.md" >/dev/null
grep -F '根据日常表达判断项目意图' "$temp/new-zh/AGENTS.md" >/dev/null

sh "$skill/scripts/init-project.sh" --project-path "$temp/partial" --language en
[ ! -f "$temp/partial/docs/tasks.md" ] || { printf 'Partial adoption duplicated TASKS.md\n' >&2; exit 1; }
[ -f "$temp/partial/docs/decisions.md" ] || { printf 'Partial adoption did not create decisions\n' >&2; exit 1; }
sh "$skill/scripts/inspect-project.sh" "$temp/partial" | grep -F 'tasks=TASKS.md' >/dev/null
sh "$skill/scripts/inspect-project.sh" "$temp/partial" | grep -F 'decisions=docs/decisions.md' >/dev/null
grep -F 'PARTIAL-TASK-CONTENT' "$temp/partial/TASKS.md" >/dev/null
fingerprint "$temp/partial" > "$temp/partial-first.cksum"
sh "$skill/scripts/init-project.sh" --project-path "$temp/partial" --language en
fingerprint "$temp/partial" > "$temp/partial-second.cksum"
cmp -s "$temp/partial-first.cksum" "$temp/partial-second.cksum" || { printf 'Partial adoption is not idempotent\n' >&2; exit 1; }

sh "$skill/scripts/init-project.sh" --project-path "$temp/custom" --language en
[ ! -f "$temp/custom/docs/tasks.md" ] || { printf 'Custom task mapping was duplicated\n' >&2; exit 1; }
[ ! -f "$temp/custom/docs/decisions.md" ] || { printf 'Custom decision mapping was duplicated\n' >&2; exit 1; }
sh "$skill/scripts/inspect-project.sh" "$temp/custom" | grep -F 'tasks=project/work-items.md' >/dev/null
sh "$skill/scripts/inspect-project.sh" "$temp/custom" | grep -F 'decisions=project/choices.md' >/dev/null
grep -F 'CUSTOM-TASK-CONTENT' "$temp/custom/project/work-items.md" >/dev/null
grep -F 'CUSTOM-DECISION-CONTENT' "$temp/custom/project/choices.md" >/dev/null
fingerprint "$temp/custom" > "$temp/custom-first.cksum"
sh "$skill/scripts/init-project.sh" --project-path "$temp/custom" --language en
fingerprint "$temp/custom" > "$temp/custom-second.cksum"
cmp -s "$temp/custom-first.cksum" "$temp/custom-second.cksum" || { printf 'Custom mapped adoption is not idempotent\n' >&2; exit 1; }

sh "$skill/scripts/update-project.sh" --project-path "$temp/invalid" --language en
if sh "$skill/scripts/validate-project.sh" "$temp/invalid"; then
  printf 'Validation accepted unresolved task and decision mappings\n' >&2
  exit 1
fi

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
