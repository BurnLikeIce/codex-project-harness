---
name: project-harness
description: Use when initializing or adopting project governance, updating an existing Project Harness project, preserving durable tasks or decisions, coordinating parallel project work, accepting and integrating results, handing control to a new conversation, or interpreting project-workflow requests such as start this project, use this conversation as control, sync the latest project-harness, update this project's harness, 验收结果, 启动项目, 旧项目接管, 同步最新规则, 更新当前项目, or 主控交接. Do not use for an ordinary isolated code change unless durable project state, coordination, acceptance, or release boundaries must change.
---

# Project Harness

## Mission

Keep project-specific facts, decisions, constraints, task state, acceptance evidence, and coordination boundaries usable across long-running agent work.

Manage the project-level contract. Do not prescribe the agent's internal planning, implementation, debugging, testing, review, tool, or delegation method.

Reply and create project-facing content in the user's language unless the project already establishes another language.

## Core Rules

1. Inspect before initializing, adopting, updating, or migrating a project.
2. Reuse existing project documents as sources of truth; do not create duplicate canonical files.
3. Record work according to durable impact, not code size.
4. Keep one active coordinator for each governed task.
5. Use one control conversation for ordinary work; add parallel execution only when it provides a concrete benefit.
6. Prefer mechanical verification for repeatable invariants and keep prose focused on intent and boundaries.
7. Do not repeat `git init`, overwrite existing documentation, or perform structural migration without explicit intent.
8. Do not commit, push, publish, deploy, release, delete, or materially expand scope without authorization from the user or established project policy.

## Route Semantic Intent

Interpret meaning rather than matching exact commands.

- **Start a new project:** inspect, initialize only missing minimal governance files, and establish the current conversation as the control context unless the user chooses otherwise.
- **Adopt an existing project:** inspect and map existing sources of truth; do not reorganize them to match a template.
- **Sync the latest Project Harness:** reload the latest skill rules for this conversation only. Do not edit files or change Git state.
- **Update the current project's Harness:** perform a backward-compatible in-place protocol update. Preserve files and custom content; update only managed Harness entry sections.
- **Migrate project structure:** inspect and propose a migration plan first. Require confirmation before moving, merging, archiving, or deleting files.
- **Discuss a possible change:** explore without creating an implementation task until the user commits to the change or durable discussion output must be recorded.
- **Proceed with the agreed change:** convert the settled outcome into the smallest sufficient task and decision records, then execute or coordinate it.
- **Report a problem:** triage directly. Fix it as a bounded task when safe; create or update durable records when impact, uncertainty, coordination, or acceptance requires them.
- **Accept or review results:** evaluate recorded criteria and evidence, then always return the control context's next action.

Read [routing.md](references/routing.md) when intent or routing is ambiguous.

## Classify Work on Two Axes

### Durable Impact

Create or update a durable task when work changes product behavior, records a meaningful decision, changes a contract or release boundary, affects downstream work, needs acceptance or rollback, or must survive a conversation or ownership change.

Record a decision when a product or technical choice and its rationale should constrain future work. A tiny change can require both a task and a decision. Purely mechanical work may remain traceable through Git alone.

### Execution Topology

- **Direct:** one bounded owner can complete and verify the work.
- **Structured:** risk, ambiguity, cross-module impact, or verification stages require an explicit execution record.
- **Coordinated:** independent units benefit from parallel ownership.

The active agent chooses how to execute. Harness records only the project contract, ownership, constraints, evidence, and integration state.

Read [project-state.md](references/project-state.md) for record rules and [coordination.md](references/coordination.md) for coordinated work.

## Use the Minimal Project Map

For a new project, default to:

- `HARNESS.md`: project map, protocol metadata, authority boundaries, and links;
- `docs/tasks.md`: durable task state;
- `docs/decisions.md`: durable product and technical decisions;
- a short managed pointer in `AGENTS.md` when safe.

Create product, architecture, API, security, deployment, testing, release, or handoff documents only when needed. Reuse equivalent existing files.

For an old Harness project, keep its existing layout. Updating is not migration.

## Govern Completion and Acceptance

An implementation result must state the task, outcome, changed scope, verification evidence, unresolved risks, and whether it is ready for acceptance. Keep the format proportional to the task.

Acceptance ends in exactly one state:

- **Accepted:** criteria are satisfied; state the next control action.
- **Rework required:** identify failed criteria and provide a directly usable instruction for the responsible execution context.
- **Blocked:** identify the dependency, owner, and required next action.
- **Superseded:** identify the replacing task or decision.

Read [acceptance.md](references/acceptance.md) when reviewing or handing off results.

## Respect Git and Release Boundaries

Use branches or worktrees only when isolation, review, or parallelism justifies them. Record ownership and integration order when concurrent writes could conflict. Keep remote writes, merges, releases, deployments, and cleanup explicitly authorized.

Read [git-release.md](references/git-release.md) for Git, GitHub, worktree, integration, and release guidance.

## Use Bundled Scripts for Deterministic Operations

- Inspect: `scripts/inspect-project.ps1` or `scripts/inspect-project.sh`
- Initialize: `scripts/init-project.ps1` or `scripts/init-project.sh`
- Update in place: `scripts/update-project.ps1` or `scripts/update-project.sh`
- Validate: `scripts/validate-project.ps1` or `scripts/validate-project.sh`

Use `-Language zh-CN` or `--language zh-CN` for Chinese templates. Follow the existing project's language during adoption or update.

Read [update-existing-project.md](references/update-existing-project.md) before updating or migrating an existing project.

## Report Project-Governance Actions

After initialization, adoption, update, migration, acceptance, integration, or handoff, report only what matters:

- detected project state and sources of truth;
- files changed or intentionally left unchanged;
- Git and authorization state;
- task, decision, acceptance, or coordination state;
- the exact next action for the control context.

Do not manufacture specialist roles, task IDs, branches, worktrees, or documents before the project needs them.
