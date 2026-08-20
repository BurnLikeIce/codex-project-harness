# Tasks

Record work that must survive a conversation, ownership, acceptance, integration, or release boundary. Do not record purely mechanical edits unless the project needs durable tracking.

## Active

### TASK-0002 — Adapt Project Harness to native Codex tasks

- Status: ready_for_review
- Created: 2026-08-20
- Outcome: Project Harness uses native Codex task creation and handoff capabilities without becoming a task orchestrator or requiring fixed product, frontend, and backend conversations.
- Scope: semantic routing for explicit task creation, clean-task context packets, full control handoff, capability fallback, execution-context boundaries, compatibility, and the v2.2 design contract.
- Constraints:
  - User-visible tasks may be created only from explicit semantic user intent.
  - New tasks are clean and independent by default; they do not inherit the full chat history.
  - The originating task does not monitor the new task and is not automatically archived.
  - Codex owns native task lifecycle behavior; Harness owns durable project continuity.
  - Existing projects remain usable without migration or new default files.
- Acceptance criteria:
  - The design separates current-task work, internal execution units, and user-visible Codex tasks.
  - Fixed product, frontend, and backend task roles are not part of the default workflow.
  - Create, fork, and full-handoff intents have distinct behavior.
  - Full handoff refreshes durable project state before creating the receiving task.
  - Missing native task capabilities degrade to a directly usable restart instruction.
  - Git worktree creation remains independent from task creation.
  - The implementation plan changes only Skill guidance, references, public documentation, and contract tests unless later evidence requires script changes.
- Linked decisions: `DEC-0002`
- Evidence: `docs/native-task-continuity-design.md`
- Next action: repository owner reviews and approves the design before implementation planning begins.

## Completed

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
- Next action: completed by squash merge `5167839`; release publication remains a separate explicitly authorized action.
