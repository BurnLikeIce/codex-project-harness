# Project Harness Workflow

## Project Start

1. Start in the real project directory.
2. Use the first Codex conversation as the master/control conversation.
3. Install harness files if they are missing.
4. Check Git status before any initialization.
5. Initialize Git only when the project is not already a repository and the user wants it.
6. Configure GitHub remote only when missing.
7. Default to single-conversation harness mode unless specialist conversations reduce risk or unblock parallel work.
8. Create or review the first MVP tasks in the master/control conversation or product mode.

## Source of Truth

Store project state in docs:

- `docs/sop.md`: operating rules.
- `docs/product.md`: product goals, users, feature scope.
- `docs/architecture.md`: system boundaries, modules, data flow.
- `docs/api-contract.md`: request/response contracts.
- `docs/documentation.md`: documentation map and role-based doc guide.
- `docs/tasks.md`: task IDs, owners, branches, status, acceptance criteria.
- `docs/intent.md`: natural-language intent mapping.
- `docs/migration.md`: existing project takeover and migration rules.
- `docs/refresh.md`: latest harness rule and project-doc refresh.
- `docs/dispatch.md`: requirement clarification and task dispatch rules.
- `docs/triage.md`: issue routing and escalation rules.
- `docs/completion.md`: implementation conversation delivery format for product acceptance.
- `docs/acceptance.md`: product acceptance and rework format.
- `docs/single-conversation-harness.md`: default one-master-conversation operating mode.
- `docs/worktrees.md`: branch/worktree policy and cleanup rules.
- `docs/handovers/current-control-state.md`: state packet for migrating to a new master/control conversation.
- `docs/decisions.md`: important decisions and rationale.
- `docs/changelog.md`: notable changes after merges.

Chat can contain reasoning, but decisions must be written into docs before implementation, release, or another conversation depends on them.

## Default Operating Mode

Default to one long-lived master/control conversation. It can switch between product, control, implementation, acceptance, release, and migration modes in the same thread.

Use specialist conversations, background agents, branches, or worktrees only when they reduce risk, isolate changes, or unblock real parallel work.

When the master/control conversation becomes too long, create a control handoff packet. Output it in chat by default; write `docs/handovers/current-control-state.md` only when the user explicitly asks to save it.

## Optional Conversation Set

- Master/control: long-lived project coordinator, Git/GitHub, PR, merge, release.
- Product/architecture: requirements, task split, API boundaries, decisions.
- Frontend: UI, pages, components, styling, client state.
- Backend: API, database, auth, server logic.
- Bugfix/CI: one focused defect, failing test, build, or deployment issue.
- Experiment: isolated prototype or uncertain approach.

## Work Cycle

1. Master conversation handles new project startup or existing project takeover using `docs/intent.md` and `docs/migration.md` when applicable.
2. Master/product mode handles `New requirement: ...` or similar natural language and clarifies the change.
3. Master/control updates docs and task state before implementation when scope changes.
4. Small and medium tasks run sequentially in the master/control conversation when practical.
5. Specialist conversations or worktrees handle assigned task IDs only when useful.
6. Implementation updates docs, runs relevant checks, commits when appropriate, and produces delivery notes for acceptance.
7. Product/acceptance mode accepts, rejects, or conditionally accepts delivered work.
8. Rejected or conditionally accepted work returns to the responsible execution mode or conversation with copy-ready rework instructions.
9. Accepted work moves to technical review, verification, PR handling, and merge.
10. Master/control updates task status and changelog.

For issues, send `Issue: ...` or similar natural language to the most relevant conversation. That conversation should use `docs/intent.md` and `docs/triage.md` to handle, record, or escalate the issue.

## Handoff

Prefer staying in the master/control conversation. When another conversation is useful, use task IDs instead of copied chat history:

```text
Read prompts/frontend.md and implement FE-001 from docs/tasks.md.
```

```text
Read prompts/backend.md and implement BE-001 from docs/tasks.md and docs/api-contract.md.
```

If a task changes, update `docs/tasks.md` and any related docs first, then send a short handoff.
