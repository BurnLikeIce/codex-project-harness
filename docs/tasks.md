# Tasks

Record work that must survive a conversation, ownership, acceptance, integration, or release boundary. Do not record purely mechanical edits unless the project needs durable tracking.

## Active

### TASK-0001 — Make Project Harness agent-first for vibe coding

- Status: ready_for_review
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
  - Durable tasks receive stable `TASK-0001`-style identifiers.
  - Agents check existing tasks and decisions before creating a new durable task.
  - Completed, cancelled, and superseded task history remains available.
  - Existing `AGENTS.md` content is preserved outside one managed Harness block.
  - The original initialization, update, validation, and cross-platform script structure remains unchanged.
  - Existing tests receive only small assertions for the new Skill and template contract.
- Linked decisions: `DEC-0001`
- Evidence: Original script changes were restored; no new adoption script remains. The PowerShell suite passes with the new Skill and template assertions. Local POSIX execution is unavailable because WSL has no installed distribution.
- Next action: review the pull request and its Windows, Linux, and macOS CI results before deciding whether to merge.

## Completed

No completed governed tasks.
