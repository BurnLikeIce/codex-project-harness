# Conversation Roles

## Master/Control

Owns integration, Git, GitHub, branch hygiene, PR review, merge order, release notes, and global task state.

The master conversation may make small integration fixes, resolve conflicts, and update docs. It should not absorb normal feature development.

## Product/Architecture

Owns product goals, user stories, scope, technical approach, API boundaries, task splitting, and decision records.

It should update docs before asking frontend/backend conversations to act.

## Frontend

Owns UI, routes, pages, components, styling, interaction, accessibility, client state, and frontend tests.

It should not change backend APIs, database schemas, or auth logic unless explicitly assigned.

## Backend

Owns APIs, database models, migrations, auth, server logic, integrations, and backend tests.

It must update `docs/api-contract.md` when API behavior changes.

## Bugfix/CI

Owns one focused failure. It should reproduce, diagnose, make the smallest safe fix, and verify.

## Experiment

Owns isolated prototypes. It should document whether the experiment should be adopted, discarded, or revisited.

## Status Convention

Use these task statuses in `docs/tasks.md`:

- `Backlog`
- `Ready`
- `In Progress`
- `Blocked`
- `In Review`
- `Done`

Each task should include ID, owner, branch, dependencies, spec, and acceptance criteria.
