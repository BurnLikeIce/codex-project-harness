# Conversation Roles

## Master/Control

Owns integration, Git, GitHub, branch hygiene, PR review, merge order, release notes, and global task state.

In single-conversation harness mode, the master/control conversation is also the ordinary product, implementation, acceptance, release, and migration surface. It should explicitly state the current mode before implementation, acceptance, release, or migration work.

The master conversation may make small and medium changes when scope, verification, and rollback are clear. Large features should still be planned first and may use specialist conversations, background agents, branches, or worktrees when isolation is useful.

## Product/Architecture

Owns product goals, user stories, scope, technical approach, API boundaries, task splitting, and decision records.

It can be a mode inside the master/control conversation. It should update docs before implementation or before asking frontend/backend conversations to act.

## Frontend

Owns UI, routes, pages, components, styling, interaction, accessibility, client state, and frontend tests.

It should not change backend APIs, database schemas, or auth logic unless explicitly assigned.

Use a separate frontend conversation only when it reduces risk or helps parallel work. Small frontend fixes can stay in the master/control conversation.

## Backend

Owns APIs, database models, migrations, auth, server logic, integrations, and backend tests.

It must update `docs/api-contract.md` when API behavior changes.

Use a separate backend conversation only when it reduces risk or helps parallel work. Small backend fixes can stay in the master/control conversation.

## Bugfix/CI

Owns one focused failure. It should reproduce, diagnose, make the smallest safe fix, and verify.

Small obvious fixes can stay in the master/control conversation. Use a separate bugfix conversation or worktree when the root cause is unclear or the change is risky.

## Experiment

Owns isolated prototypes. It should document whether the experiment should be adopted, discarded, or revisited.

Experiments are good candidates for isolation, but they still need clear adoption/discard criteria.

## Handoff/Migration

When the master/control conversation becomes too long, use `docs/handovers/current-control-state.md` or its localized version as the handoff packet for a new master/control conversation. The packet should capture current mode, Git state, active tasks, uncommitted changes, key decisions, safety boundaries, and a startup prompt.

## Status Convention

Use these task statuses in `docs/tasks.md`:

- `Backlog`
- `Ready`
- `In Progress`
- `Blocked`
- `In Review`
- `Done`

Each task should include ID, owner, branch, dependencies, spec, and acceptance criteria.
