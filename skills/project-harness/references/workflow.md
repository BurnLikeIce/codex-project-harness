# Project Harness Workflow

## Project Start

1. Start in the real project directory.
2. Use the first Codex conversation as the master/control conversation.
3. Install harness files if they are missing.
4. Check Git status before any initialization.
5. Initialize Git only when the project is not already a repository and the user wants it.
6. Configure GitHub remote only when missing.
7. Create or review the first MVP tasks with the product/architecture conversation.

## Source of Truth

Store project state in docs:

- `docs/sop.md`: operating rules.
- `docs/product.md`: product goals, users, feature scope.
- `docs/architecture.md`: system boundaries, modules, data flow.
- `docs/api-contract.md`: request/response contracts.
- `docs/tasks.md`: task IDs, owners, branches, status, acceptance criteria.
- `docs/intent.md`: natural-language intent mapping.
- `docs/migration.md`: existing project takeover and migration rules.
- `docs/dispatch.md`: requirement clarification and task dispatch rules.
- `docs/triage.md`: issue routing and escalation rules.
- `docs/completion.md`: implementation conversation delivery format for product acceptance.
- `docs/acceptance.md`: product acceptance and rework format.
- `docs/decisions.md`: important decisions and rationale.
- `docs/changelog.md`: notable changes after merges.

Chat can contain reasoning, but decisions must be written into docs before other conversations depend on them.

## Default Conversation Set

- Master/control: long-lived project coordinator, Git/GitHub, PR, merge, release.
- Product/architecture: requirements, task split, API boundaries, decisions.
- Frontend: UI, pages, components, styling, client state.
- Backend: API, database, auth, server logic.
- Bugfix/CI: one focused defect, failing test, build, or deployment issue.
- Experiment: isolated prototype or uncertain approach.

## Work Cycle

1. Master conversation handles new project startup or existing project takeover using `docs/intent.md` and `docs/migration.md` when applicable.
2. Product conversation handles `New requirement: ...` or similar natural language and clarifies the change.
3. Product conversation handles `Requirement discussion is done. Please dispatch tasks.` or similar natural language by updating docs and outputting copy-ready task instructions.
4. Master conversation reviews the task split.
5. Feature conversations work on assigned task IDs using separate branches or worktrees.
6. Feature conversations update docs, run relevant checks, commit, and output task deliveries for product acceptance.
7. Product conversation accepts, rejects, or conditionally accepts delivered work.
8. Rejected or conditionally accepted work returns to the responsible conversation with copy-ready rework instructions.
9. Accepted work moves to master for technical review, verification, PR handling, and merge.
10. Master updates task status and changelog.

For issues, send `Issue: ...` or similar natural language to the most relevant conversation. That conversation should use `docs/intent.md` and `docs/triage.md` to handle, record, or escalate the issue.

## Handoff

Use task IDs instead of copied chat history:

```text
Read prompts/frontend.md and implement FE-001 from docs/tasks.md.
```

```text
Read prompts/backend.md and implement BE-001 from docs/tasks.md and docs/api-contract.md.
```

If a task changes, update `docs/tasks.md` and any related docs first, then send a short handoff.
