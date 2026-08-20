# Project Harness Design Contract

## Purpose

Project Harness is a project-governance skill for coding agents. It keeps durable project facts, decisions, constraints, task state, acceptance evidence, and coordination boundaries legible across long-running work.

Project Harness does not prescribe how an implementation task must be reasoned about or executed. The active agent may choose its own planning, debugging, testing, review, tool, and delegation methods within the project's recorded constraints.

## Core Principles

1. Keep project-specific facts in versioned project files rather than relying on chat history.
2. Give agents a small project map and load deeper context only when the task requires it.
3. Record work according to durable impact, not code size.
4. Choose execution topology independently from documentation impact.
5. Enforce hard, repeatable invariants mechanically when practical; do not replace verification with more prose.
6. Keep ordinary work in the current task. Create a user-visible task only from explicit semantic user intent.
7. Keep one active coordinator for each task, regardless of the runtime or delegation mechanism used.
8. Preserve existing project facts and customized documentation during every update.
9. Treat structural migration as optional. Existing Harness projects must remain usable without migration.
10. Keep Git commits, remote writes, releases, deployments, destructive actions, and material scope expansion behind explicit project or user authorization.
11. Separate Skill activation from persistence. Selecting or naming Project Harness loads its rules but does not by itself authorize project-file changes.
12. Keep durable identifiers agent-maintained and concurrency-safe through one project coordinator.

## Ownership Boundary

Project Harness owns:

- the project knowledge map and sources of truth;
- durable task and decision records;
- product, architecture, contract, release, and authority boundaries;
- task ownership and coordination constraints;
- acceptance evidence and next-action state;
- control handoff and recovery after a conversation change;
- integration, release, and rollback gates.

Project Harness does not own:

- model reasoning style;
- implementation methodology;
- mandatory planning, TDD, debugging, or review rituals;
- tool selection;
- runtime-specific agent or subagent behavior;
- native task creation, display, switching, forking, or retention;
- a fixed number of conversations, branches, or worktrees;
- detection of or dependency on auxiliary skills.

## Semantic Intents

Recognize user meaning rather than exact phrases. The following phrases are canonical examples, not keyword requirements.

### Activate Project Harness

Examples: selecting the Skill while asking "What does this project need?" or saying "Use project-harness to review this setup."

Load the rules and route from the requested meaning. Selection or naming alone is not permission to write project files; exploratory and status-only requests remain read-only.

### Start or resume project work

Examples: "I want to build an app", "Continue this project", or "Go ahead with the agreed change."

Inspect the actual project state, preserve existing sources, and establish only missing governance state when execution is clearly approved. Never repeat `git init` when a repository already exists.

### Adopt a project

Examples: "Use project-harness to manage this project" or "Apply Project Harness here."

The request to manage the project authorizes the smallest persistent binding. Inspect and map existing sources category by category, create only missing task or decision ledgers, validate the binding, and do not reorganize existing documentation merely to match a template.

### Sync the current conversation

Example: "Sync the latest project-harness."

Reload the latest skill rules for the current conversation. Do not edit project files, update templates, create commits, or migrate structure. A sync operation must leave the Git working tree unchanged.

### Update the current project

Example: "Update this project's project-harness."

Apply an in-place, backward-compatible Harness protocol update. Preserve all existing files and project content. Update only the managed Harness metadata or entry-point sections needed for future conversations to discover the current protocol and project knowledge map.

### Migrate project structure

Example: "Migrate this project to the latest Harness structure."

Treat this as an optional structural operation. Inspect first, propose a plan, and require confirmation before moving, merging, archiving, or deleting existing files.

### Create or fork a Codex task

Examples: "Create a new task for the login page" or "Fork this task to try another approach."

Use native task capabilities only after explicit semantic intent. Create a clean independent task by default; inherit current context only for an explicit fork. Pass project-related tasks a compact self-contained packet, keep the originating task available, and do not monitor the new task by default.

### Hand off to another task

Example: "Hand this project to a new task."

Refresh durable tasks, decisions, evidence, and the project map. Deliver the recovery packet through native task capabilities when available and return `HANDOFF_COMPLETE`. Otherwise return `READY_TO_HANDOFF` and one directly usable restart instruction. Never archive the originating task automatically.

## Adaptive Routing

Classify two independent dimensions.

### Durable impact

Create or update a durable task record when work:

- changes user-visible behavior or product rules;
- contains a product or technical decision;
- changes an API, schema, permission, security, deployment, or release contract;
- affects downstream modules or future work;
- requires acceptance, rollback, handoff, or recovery;
- spans multiple steps, owners, conversations, branches, or worktrees.

Record a decision when a meaningful choice and its rationale should constrain future work. A small code change may require both a task and a decision. A purely mechanical edit may require neither and can remain traceable through Git.

### Execution topology

- **Direct:** one bounded owner can complete and verify the work.
- **Structured:** the work is risky, cross-module, ambiguous, or requires multiple verification stages.
- **Coordinated:** the work contains independent units that benefit from parallel ownership.

The active agent chooses the implementation method. Harness records only the project-level contract, ownership, boundaries, evidence, and integration state.

## Project Knowledge Model

### Minimal new-project footprint

- `HARNESS.md`: project map, protocol metadata, authority boundaries, and links to deeper sources.
- `docs/tasks.md`: durable task state that must survive conversation changes.
- `docs/decisions.md`: durable product and technical decisions.
- `AGENTS.md`: create only when absent or add a managed pointer when safe; keep it short and project-specific.

Create product, architecture, API, security, deployment, testing, release, or handoff documents only when the project actually needs them. Reuse equivalent existing files instead of creating duplicate canonical sources.

Generic workflow explanations belong in the skill's `references/` directory, not in every generated project.

Task and decision records are agent-maintained. One active project coordinator allocates global identifiers, re-reads the ledger, and reserves the next unused identifier before parallel dispatch. Execution units use assigned references and return unnumbered proposals for newly discovered durable work.

## Backward-Compatible Project Update

V1 project layouts remain valid storage layouts. V2 must understand their existing task, decision, product, architecture, API, acceptance, handoff, and workflow files without requiring renames.

An in-place project update may:

1. inspect the existing document map;
2. create `HARNESS.md` only when it does not exist;
3. add or replace one clearly delimited managed block in `HARNESS.md`;
4. add or replace one short managed pointer in `AGENTS.md` when safe;
5. report unresolved or conflicting sources of truth.

An in-place project update must not:

- delete, move, rename, archive, or rewrite existing project documents;
- overwrite text outside managed blocks;
- edit business code;
- initialize Git when Git already exists;
- commit, push, publish, deploy, or create a release without authorization;
- treat unchanged V1 workflow templates as more authoritative than current Harness protocol rules;
- demote project-specific facts or customized rules merely because they live in a V1 file.

The update must be idempotent: running it repeatedly with the same skill version and project state produces no additional diff.

## Coordination Contract

When work is coordinated, record:

- one task coordinator;
- each execution unit's goal and owner;
- allowed file, module, branch, or worktree scope when overlap is risky;
- dependencies and integration order;
- acceptance evidence required from each unit;
- the final integration and acceptance owner.

The active project coordinator is the only allocator for project-wide task and decision identifier sequences. If shared durable state cannot be updated before parallel work begins, use temporary execution references and allocate durable identifiers during integration.

Do not require a specific runtime, subagent implementation, conversation type, branch strategy, or worktree strategy. Select those mechanisms according to project risk and available capabilities.

## Acceptance Contract

Every governed task ends in one of these states:

- **Accepted:** evidence satisfies the recorded criteria; return the next project action.
- **Rework required:** identify each failed criterion and provide a directly usable instruction for the responsible execution context.
- **Blocked:** state the unresolved dependency, owner, and required next action.
- **Superseded:** link the replacing task or decision.

Acceptance must always return a next action for the control context, including when the work is accepted.

## Handoff Contract

Task replacement must not require reconstructing old chat history. Update durable project state first and use native clean-task creation and message delivery when available. A delivered handoff ends with `HANDOFF_COMPLETE`; otherwise return `READY_TO_HANDOFF` and a restart instruction that tells the receiving task to read `AGENTS.md`, `HARNESS.md`, and the current task and decision state before resuming the recorded next action.

## Skill Structure

V2 should converge toward:

```text
skills/project-harness/
  SKILL.md
  agents/openai.yaml
  assets/minimal-project/
    HARNESS.md
    docs/tasks.md
    docs/decisions.md
  references/
    routing.md
    project-state.md
    coordination.md
    acceptance.md
    git-release.md
    update-existing-project.md
  scripts/
    inspect-project.ps1
    inspect-project.sh
    init-project.ps1
    init-project.sh
    update-project.ps1
    update-project.sh
    validate-project.ps1
    validate-project.sh
```

Keep reference files conditional and avoid repeating the same policy in multiple files. Scripts are for deterministic inspection, copying, managed-block updates, and validation; contextual project decisions remain with the agent.

## V2 File-Level Change Plan

### Rewrite

- `skills/project-harness/SKILL.md`
- `skills/project-harness/agents/openai.yaml`
- root `README.md` and `README.zh-CN.md` after behavior stabilizes

### Replace with focused references

- `references/workflow.md`
- `references/conversation-roles.md`
- `references/git-github.md`

### Replace active project template

- stop installing the current 50-file V1 project template for new projects;
- install the minimal project footprint by default;
- retain V1 compatibility knowledge in the updater and tests, not as the default output template.

### Add

- deterministic in-place project update scripts;
- deterministic Harness validation scripts;
- V1 and customized-V1 test fixtures;
- behavior tests for semantic intent, sync immutability, update idempotence, and non-destructive compatibility.

## Release Gates

V2 is ready for installation and public release only when:

1. skill validation passes;
2. a new project receives only the minimal default footprint;
3. conversation sync produces no project diff;
4. V1 in-place update preserves all existing files and custom content;
5. repeated update is idempotent;
6. customized existing documentation remains authoritative;
7. task and decision routing handles both small high-impact changes and large mechanical work;
8. acceptance always produces a control-context next action;
9. Windows and macOS/Linux scripts pass representative tests;
10. the installed local skill matches the tested repository source;
11. current files and Git history pass privacy and secret review;
12. README files describe V2 behavior accurately.
13. selecting the Skill during exploration causes no project-file changes;
14. adoption preserves valid custom mappings, reuses partial existing sources, creates only missing ledgers, and rejects unmapped required sources;
15. coordinator-owned identifiers cannot be allocated independently by parallel execution units;
16. conversation handoff produces durable resumable state and a directly usable restart instruction.

Changing repository visibility and publishing a release remain separate, explicitly authorized actions after these gates pass.
