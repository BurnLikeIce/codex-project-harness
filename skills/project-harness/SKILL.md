---
name: project-harness
description: Use for ongoing software-project work when a user starts or resumes a project, explores or approves a feature, reports a project problem, asks for review, acceptance, or status, coordinates parallel work, asks to create or fork a Codex task for project work, or hands the project to another task. Also use when HARNESS.md or a Project Harness entry is present and work may affect durable project state or release boundaries. Match ordinary English or Chinese intent such as "continue this project", "go ahead", "create a new task for this", "接着做", "按这样开始", "新建一个任务做这个", "这里不对", or "验收一下"; do not require the skill name or exact commands. Do not use for unrelated Q&A, translation, or isolated mechanical edits with no durable project impact.
---

# Project Harness

## Mission

Keep project-specific facts, decisions, constraints, task state, acceptance evidence, and coordination boundaries usable across long-running agent work.

Manage the project-level contract. Do not prescribe the agent's internal planning, implementation, debugging, testing, review, tool, or delegation method.

Reply and create project-facing content in the user's language unless the project already establishes another language.

## Core Rules

1. Infer project intent from ordinary language; do not require exact phrases or internal Harness vocabulary.
2. Inspect before applying governance, refreshing managed sections, or changing project structure.
3. Treat broad activation as permission to route and inspect, not automatic permission to write files. Keep exploration read-only until the user clearly starts, resumes, or approves execution.
4. Reuse existing project documents as sources of truth; do not create duplicate canonical files.
5. Record work according to durable impact, not code size.
6. Keep one active coordinator for each governed task. Treat coordinator and control-context terminology as internal unless coordination or handoff requires explanation.
7. Keep ordinary work in the current task. Create a user-visible Codex task only when the user explicitly asks to create, separate, fork, or hand off work.
8. Prefer mechanical verification for repeatable invariants and keep prose focused on intent and boundaries.
9. Do not repeat `git init`, overwrite existing documentation, or perform structural migration without explicit intent.
10. Do not commit, push, publish, deploy, release, delete, or materially expand scope without authorization from the user or established project policy.

## Route Semantic Intent

Interpret meaning rather than matching exact commands.

- **Start or resume project work:** activate from ordinary project language. If the user is only exploring, discuss without creating governance files or implementation records. When the user clearly starts, resumes, or approves execution, inspect the current state, map reusable sources of truth, create only missing governance files, and use the current conversation as the internal coordinator unless another owner is already established.
- **Continue a governed project:** when `HARNESS.md` or a Project Harness entry in `AGENTS.md` is present, read the project map before durable changes and apply the currently installed rules automatically. Do not ask the user to invoke the skill again.
- **Explicitly activate Project Harness:** Selecting or naming the Skill loads its rules, but selection alone does not authorize project-file changes. Infer the requested action from the user's semantic intent and keep exploration read-only.
- **Explicitly adopt Project Harness:** When the user asks to use, adopt, set up, or apply Project Harness to manage the current project, treat that management request as permission to write the smallest safe project binding. Inspect first, reuse equivalent sources, create only missing ledgers, validate the result, and report `ADOPTED`, `ALREADY_ADOPTED`, or `BLOCKED`.
- **Sync the latest Project Harness:** reload the latest skill rules for this conversation only. Do not edit files or change Git state.
- **Refresh project bindings:** when the user asks to apply the installed rules to project files, preserve files and custom content and update only managed Harness entry sections.
- **Migrate project structure:** inspect and propose a migration plan first. Require confirmation before moving, merging, archiving, or deleting files.
- **Discuss a possible change:** explore without creating an implementation task until the user commits to the change or durable discussion output must be recorded.
- **Proceed with the agreed change:** convert the settled outcome into the smallest sufficient task and decision records, then execute or coordinate it.
- **Report a problem:** triage directly. Fix it as a bounded task when safe; create or update durable records when impact, uncertainty, coordination, or acceptance requires them.
- **Accept or review results:** evaluate recorded criteria and evidence, then always return the control context's next action.
- **Create a new task:** only explicit semantic intent authorizes a user-visible task. Use the runtime's native task capability when available. For project work, create a clean, independent task by default and give it a compact, self-contained project packet. Keep the originating task available; do not monitor the new task by default.
- **Fork the current task:** use native context inheritance only when the user explicitly asks to fork, branch the discussion, or try an alternative with the current context.
- **Hand off the whole project:** refresh durable tasks, decisions, evidence, and the project map first. Use native task creation and message delivery when available. After successful delivery return `HANDOFF_COMPLETE`; otherwise return `READY_TO_HANDOFF` plus one directly usable restart instruction. Do not archive the originating task automatically.

## Use Native Tasks Lightly

Distinguish user-visible Codex tasks from internal execution units. Internal workers may be chosen by the active agent; user-visible tasks belong to the user's workspace and require explicit user intent.

For project-related task creation, send only the objective, project path, sources to read first, settled constraints, acceptance criteria, prohibited operations, and recorded next action. Do not copy the full chat history. Do not create fixed product, frontend, or backend task roles.

Creating a Codex task does not by itself authorize a Git branch, worktree, commit, push, merge, release, or deployment. If native task creation or cross-task messaging is unavailable, preserve the repository-first handoff fallback instead of simulating another task manager.

## Maintain Agent-First Project History

Users may inspect task and decision records, but the active coordinator maintains identifiers, status, evidence, and history automatically.

Before creating a durable task, inspect relevant task and decision history. Continue active work when it matches, reuse an accepted result when it already satisfies the request, link regressions and extensions to their earlier work, and surface conflicts before replacing an accepted decision.

When the project has no established identifier system, use stable `TASK-0001` and `DEC-0001` identifiers. The active project coordinator owns allocation and reserves identifiers in durable state before parallel dispatch; execution units do not independently allocate global identifiers. Never reuse an identifier or delete completed, cancelled, or superseded history.

Read [routing.md](references/routing.md) for the activation order, persistence boundary, and semantic routing matrix.

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

When the project has no equivalent governance sources, default to:

- `HARNESS.md`: project map, protocol metadata, authority boundaries, and links;
- `docs/tasks.md`: durable task state;
- `docs/decisions.md`: durable product and technical decisions;
- a short managed pointer in `AGENTS.md` when safe.

Create product, architecture, API, security, deployment, testing, release, or handoff documents only when needed. Reuse equivalent existing files.

Before creating any file, map equivalent project sources and preserve the current layout. Structural reorganization is a separate, explicit operation.

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

Use `-Language zh-CN` or `--language zh-CN` for Chinese templates. Follow the project's established language when refreshing managed sections.

Read [update-existing-project.md](references/update-existing-project.md) before refreshing managed sections or changing project structure.

## Report Project-Governance Actions

After initialization, adoption, update, migration, acceptance, integration, or handoff, report only what matters:

- detected project state and sources of truth;
- files changed or intentionally left unchanged;
- Git and authorization state;
- task, decision, acceptance, or coordination state;
- the exact next action for the control context.

Do not manufacture specialist roles, task IDs, branches, worktrees, or documents before the project needs them.
