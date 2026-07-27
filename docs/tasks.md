# Tasks

Record work that must survive a conversation, ownership, acceptance, integration, or release boundary. Do not record purely mechanical edits unless the project needs durable tracking.

## Active

### TASK-0001 — Make Project Harness agent-first for vibe coding

- Status: accepted
- Created: 2026-07-24
- Outcome: Explicitly applying Project Harness persistently adopts the project, while agents autonomously maintain durable task and decision history for vibe coding users.
- Scope: activation semantics, agent-maintained task and decision history, minimal templates, related references, public documentation, and small checks in the existing test entry points.
- Constraints:
  - Default language and concepts must remain understandable to non-developers.
  - Existing project content must be preserved.
  - Jira, ADR, and other professional systems remain optional advanced compatibility, not onboarding requirements.
  - The repository owner retains merge and release authority.
- Acceptance criteria:
  - Explicit adoption creates or confirms an observable, validated project binding.
  - Selecting or naming the Skill without adoption or execution intent remains read-only.
  - Adoption preserves valid custom mappings, reuses partial existing task or decision sources, creates only missing ledgers, and validation rejects unresolved required mappings.
  - Durable tasks receive stable `TASK-0001`-style identifiers.
  - One active project coordinator reserves project-wide task and decision identifiers before parallel dispatch.
  - Agents check existing tasks and decisions before creating a new durable task.
  - Completed, cancelled, and superseded task history remains available.
  - Existing `AGENTS.md` content is preserved outside one managed Harness block.
  - Conversation handoff produces durable resumable state, `READY_TO_HANDOFF`, and a directly usable restart instruction.
  - The original initialization, update, validation, and cross-platform script entry points remain available.
  - Existing tests cover the revised Skill, adoption, validation, handoff, and template contract.
- Linked decisions: `DEC-0001`
- Evidence: PowerShell and POSIX behavior suites pass for English and Chinese initialization, V1-compatible update, partial-source adoption, custom mapped sources, idempotence, and rejection of unresolved mappings. PowerShell and shell syntax checks pass, the Skill validator passes in UTF-8 mode, `git diff --check` reports no whitespace errors, and the final Windows, Ubuntu, and macOS GitHub Actions jobs pass. The repository owner accepted the result for merge.
- Next action: merge the accepted pull request. Keep release publication as a separate explicitly authorized action.

## Completed

No completed governed tasks.
