# Single-Conversation Harness Mode

This document defines the default lightweight operating mode for a project harness: one long-lived master/control conversation can carry product discussion, task planning, implementation, acceptance, and release decisions.

Specialist conversations, background agents, branches, and worktrees remain available, but they are optional tools for risk, isolation, or parallelism.

## Core Principles

- Default to one master/control conversation for ordinary project work.
- Switch roles inside the same conversation when practical: product, control, implementation, acceptance, release, or migration.
- Keep project docs as the source of truth. Important product decisions, task scope, acceptance criteria, version state, and release decisions must be recorded.
- Ask for explicit user confirmation before GitHub push, production deploy, production database changes, deleting worktrees, or deleting branches.
- Do not create specialist conversations or worktrees just because a task mentions frontend, backend, bugfix, or acceptance.

## Role Modes

The master/control conversation may explicitly enter these modes:

- Product mode: discuss users, value, scope, priority, risks, and acceptance criteria.
- Control mode: update task/decision docs, order work, manage Git and release gates.
- Implementation mode: edit code or docs within a clear task boundary.
- Acceptance mode: run checks, inspect pages or outputs, and compare against acceptance criteria.
- Migration mode: summarize current state so a new master/control conversation can take over.

Before implementation, acceptance, release, or migration work, briefly state the mode and the intended action.

## Execution Levels

Small tasks can run directly in the main working tree:

- Documentation updates.
- Small copy/style changes.
- Single-file or low-risk fixes.
- Recording product acceptance or task state.

Medium tasks can still run in the master/control conversation, but first state:

- Scope.
- Expected files or modules.
- Verification method.
- Rollback point.

Parallel or isolated tasks may use background agents, specialist conversations, branches, or worktrees when they are genuinely helpful.

Good candidates:

- Read-only code investigation.
- Small independent patches.
- Tests or builds that can run while the user continues product discussion.
- Work that does not need live product decisions.

Poor candidates:

- Tasks needing real-time product judgment.
- Multiple agents editing the same files.
- Production release, production database changes, or destructive Git/worktree cleanup.

## Worktree Rule

A worktree is an isolation tool, not a requirement to open a new conversation.

- Do not create a worktree by default for every task.
- Consider a worktree for high-risk, parallel, conflict-prone, or isolated validation work.
- Before creating one, explain the reason, path, branch, and cleanup plan, then wait for user confirmation.
- After the task, recommend cleanup first. Do not delete automatically.

## Documentation Gates

Single-conversation mode does not reduce project discipline:

1. Product decisions go into `docs/decisions.md` or the relevant product doc.
2. Task scope, owner, dependencies, and acceptance criteria go into `docs/tasks.md`.
3. API or data shape changes go into `docs/api-contract.md`.
4. Version or release state goes into the project's version/changelog docs when present.
5. Long-lived workflow changes go into `HARNESS.md` and this document.

## Control Handoff Packet

When the master/control conversation becomes too long, or the user wants to move to a new conversation, create a control handoff packet.

Natural-language triggers:

- "Make a control handoff packet."
- "Prepare this project for a new master conversation."
- "Summarize the current control state."
- "Write the control handoff packet."

Default behavior:

- If the user asks to "make" or "prepare" a handoff packet, output it in chat and do not edit files.
- If the user explicitly asks to "write" or "save" the handoff packet, update `docs/handovers/current-control-state.md` or the matching localized file.

The packet should include:

- Current work mode.
- Project path.
- Git status.
- Current version or milestone target.
- Completed tasks.
- Active tasks.
- Uncommitted changes.
- Key decisions.
- Safety boundaries.
- Next recommended steps.
- Startup prompt for the new master/control conversation.

## New Master Conversation Startup

A new master/control conversation should first read:

- `docs/handovers/current-control-state.md` or the matching localized file.
- `HARNESS.md`.
- `docs/single-conversation-harness.md`.
- `docs/tasks.md`.
- `docs/decisions.md`.
- Project-specific version, deployment, or local development docs when present.

Startup should only initialize role and restate state. Do not edit code, push, deploy, or clean up branches/worktrees during startup unless the user explicitly asks.
