# Current Control State

Last updated: YYYY-MM-DD

This is the current master/control conversation handoff packet. A new master/control conversation should read this file before continuing the project.

## Current Work Mode

- Default mode:
- Active role:
- Collaboration pattern:

## Project Path

```text
<project path>
```

## Git Status Snapshot

Run these before starting new work:

```text
git status --short --branch
git diff --name-status
```

Latest known snapshot:

```text
branch:
HEAD:
remote status:
working tree:
```

## Current Version Or Milestone

- Target:
- Scope:
- Out of scope:

## Completed Tasks

- `<TASK-ID>`:

## Active Tasks

- `<TASK-ID>`:

## Uncommitted Or Untracked Changes

- `<path>`:

## Key Decisions

- `<date>`:

## Safety Boundaries

- Do not push, deploy, change production data, delete branches, or delete worktrees without explicit user confirmation.
- Do not overwrite existing project docs during migration or refresh.
- Re-check Git status before implementation or release work.

## Next Recommended Steps

1. Re-check Git status.
2. Confirm the next task or product decision.
3. Update task/decision docs before implementation when scope changes.

## New Master Conversation Startup Prompt

```text
You are the new master/control conversation for this project.

Please read:
- <project path>/docs/handovers/current-control-state.md
- <project path>/HARNESS.md
- <project path>/docs/single-conversation-harness.md
- <project path>/docs/tasks.md
- <project path>/docs/decisions.md

First only initialize the role and restate the current state. Do not edit code, push, deploy, or clean up branches/worktrees.
```
