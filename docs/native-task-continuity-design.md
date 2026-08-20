# Native Codex Task Continuity Design

- Status: ready_for_review
- Date: 2026-08-20
- Task: `TASK-0002`
- Decision: `DEC-0002`
- Target release: Project Harness v2.2.0

## Summary

Project Harness will adapt to native Codex task creation without duplicating Codex task management. Codex owns creation, display, switching, forking, and retention of user-visible tasks. Harness owns durable project facts, task and decision state, acceptance boundaries, and the compact context needed to continue work safely in another task.

The default remains one current task. Harness creates no user-visible task unless the user explicitly expresses creation, separation, fork, or control-transfer intent. Product, frontend, and backend are possible work domains, not default task roles.

## Goals

1. Let users say ordinary phrases such as “新建一个任务做登录页” or “换个任务继续这个项目” and use native Codex task capabilities when available.
2. Preserve project continuity without copying full chat history.
3. Keep Harness lightweight, capability-aware, and independent of a particular runtime tool name.
4. Distinguish independent task creation, explicit forking, and full control handoff.
5. Preserve a usable fallback when native task creation or cross-task messaging is unavailable.

## Non-Goals

- Do not automatically create user-visible tasks based only on complexity or possible parallelism.
- Do not restore fixed product, frontend, backend, bug-fix, or experiment conversations.
- Do not make Harness responsible for sidebar organization, task archiving, or continuous task monitoring.
- Do not automatically archive the originating task.
- Do not equate a new task with a new Git branch or worktree.
- Do not add default project files or change Harness Protocol 2.
- Do not prescribe internal subagent or auxiliary-skill behavior.

## Terminology

### Current task

The user-visible Codex task in which the current request is being handled. It remains the default place for ordinary project work.

### Internal execution unit

A bounded runtime worker or subagent used inside a task. It is not a user-visible long-lived task and is outside the native-task continuity lifecycle defined here.

### User-visible task

A Codex task that appears to the user and can be opened and continued independently. Creating one requires explicit semantic user intent.

### Control handoff

Transfer of responsibility for continuing the whole project from the current task to a new user-visible task. This is distinct from creating an independent task for one bounded outcome.

## Ownership Boundary

### Codex owns

- native task creation, display, switching, forking, linking, and retention;
- delivery of an initial message to a newly created task when supported;
- user-facing task navigation and lifecycle controls.

### Project Harness owns

- whether project state must be refreshed before the new task starts;
- durable task and decision records;
- the compact project packet supplied to a project-related task;
- control-transfer state and the fallback restart instruction;
- Git, worktree, integration, acceptance, and release boundaries.

Harness must not simulate a second task manager on top of Codex.

## Semantic Routing

Interpret meaning rather than requiring exact phrases.

| Intent | Example | Behavior |
| --- | --- | --- |
| Continue here | “开始做这个功能” | Stay in the current task. Do not create a user-visible task. |
| Create independent task | “新建一个任务做登录页” | Use native creation when available. Create a clean, independent task and send the project packet when the work belongs to the current project. |
| Separate an outcome | “把支付回调放到一个新任务” | Create one outcome-oriented task. Do not assign a permanent backend role. |
| Explicit fork | “派生当前任务试另一个方案” | Use native fork behavior only because the user explicitly requested context inheritance or divergence. |
| Full control handoff | “换个任务继续整个项目” | Refresh durable state, create a clean receiving task, send the recovery packet, and mark the transfer complete. Keep the old task visible. |
| Unrelated native task | “新建一个任务帮我规划旅行” | Let Codex handle task creation normally. Do not introduce Harness records for the software project. |

“新建任务” is explicit creation authority. “把前端和后端分开做” also expresses task separation semantically even if it does not contain a fixed command. A request such as “开始实现” does not authorize creating user-visible tasks.

## New Independent Task Flow

1. Confirm that the user explicitly requested a new or separated task.
2. Determine whether the requested work belongs to the governed project.
3. If the work has durable impact, reserve or update the relevant project task record before creation.
4. Create a clean native task when the capability is available.
5. Send a compact, self-contained project packet rather than full chat history.
6. Return the new task entry to the user.
7. Record the native task identifier or link only when it is available and useful for durable recovery.
8. Stop coordinating by default. The new task runs independently and the user follows it directly.

The originating task remains visible and is never automatically archived.

## Full Control Handoff Flow

1. Update durable task status, decisions, verification evidence, protected constraints, and exact next action.
2. Create or refresh a focused handoff file only when unresolved context cannot fit existing task and decision records.
3. Create a clean user-visible task through the native runtime capability.
4. Deliver the recovery packet to the receiving task when cross-task messaging is available.
5. The receiving task reads `AGENTS.md`, `HARNESS.md`, the current task record, linked decisions, and any mapped handoff source before changing durable state.
6. After the recovery packet is delivered successfully, make the receiving task the active project coordinator.
7. Return `HANDOFF_COMPLETE`, the new task entry, and a concise statement that the old task remains available.
8. Do not monitor the receiving task and do not archive the originating task.

If native creation or message delivery is unavailable, keep the originating task authoritative, update durable state as above, and return `READY_TO_HANDOFF` plus one directly usable restart instruction. The fallback remains a successful prepared handoff, not a failed project migration. Control transfers only after the receiving task obtains the recovery packet.

## Project Packet

The packet must be short, self-contained, and localized to the user. Include only fields that matter:

```text
Project directory:
Task objective:
Scope and boundaries:
Sources to read first:
Settled decisions and protected constraints:
Acceptance criteria:
Prohibited operations:
Recorded next action:
```

The packet must not include full chat transcripts, generic SOP prose, speculative roles, or details already discoverable from the listed project sources.

## State Recording

Project task records may include an optional execution-context field when a user-visible task is materially relevant:

```text
- Execution context: native Codex task <identifier or link>
```

This field is optional and must not block work when the runtime does not expose a stable identifier. Harness does not maintain a separate registry of every Codex task.

For full handoff, the durable task record identifies the receiving task when possible and states that the originating task remains retained. For an independent new task, recording the link is necessary only when later integration, acceptance, or recovery depends on it.

## Git and Worktree Boundary

Task topology and Git topology remain independent:

- A new user-visible task does not automatically create a branch or worktree.
- Read-only research, product discussion, and sequential work may use the existing workspace.
- Concurrent tasks that may both write before integration should use separate worktrees. The decision is based on concurrent write risk, not on the existence of two user-visible tasks alone.
- Branch creation, remote push, merge, release, deployment, and cleanup retain their existing authorization rules.

When the runtime creates a task in a different workspace automatically, Harness records the actual workspace or worktree only while it affects integration.

## Capability Adaptation and Fallback

Harness detects behavior semantically from capabilities available in the current runtime. The public protocol must not require one hard-coded task tool name.

Preferred capability order:

1. native clean-task creation plus initial-message delivery;
2. native clean-task creation with a restart instruction returned to the user;
3. repository-first `READY_TO_HANDOFF` fallback with a directly usable instruction.

Explicit fork requests may use native context-forking when available. Harness must not silently replace clean task creation with a context fork because that would violate the selected default.

Capability absence must not trigger project-file migration, template expansion, or installation of an auxiliary dependency.

## Error and Safety Behavior

- If task creation fails before a new task exists, keep the originating task authoritative and return the error plus the prepared restart instruction.
- If creation succeeds but message delivery fails, keep the originating task authoritative and return `READY_TO_HANDOFF`, the new task entry, and the exact packet the user can send there.
- If durable state cannot be refreshed safely, do not claim `HANDOFF_COMPLETE`; return `BLOCKED` with the missing action.
- If the project path or target workspace is ambiguous and the answer changes write scope, ask one concise question before creation.
- Never create additional user-visible tasks while retrying unless the prior creation is confirmed absent.

## Compatibility and Versioning

This is a backward-compatible Project Harness v2.2.0 behavior update:

- Harness Protocol remains 2.
- Existing `HARNESS.md`, task, decision, and optional handoff sources remain valid.
- Existing projects require no migration and no automatic project-file update.
- Updating the installed Skill is sufficient for ordinary use.
- Runtimes without native task management continue using the repository-first fallback.
- Project Harness remains independent of auxiliary skills.

## File-Level Implementation Scope

Implementation is expected to update:

- `skills/project-harness/SKILL.md`: native-task authority boundary and semantic routes;
- `skills/project-harness/references/routing.md`: create, fork, and full-handoff intents;
- `skills/project-harness/references/coordination.md`: execution-context distinctions and independent-task behavior;
- `skills/project-harness/references/project-state.md`: optional execution-context link;
- `skills/project-harness/references/git-release.md`: task/worktree independence;
- `docs/harness-v2-design.md`: runtime ownership and continuity contract;
- `README.md` and `README.zh-CN.md`: concise natural-language examples;
- `CHANGELOG.md`, `docs/tasks.md`, and `docs/decisions.md`: release and governance state;
- existing test entry points: focused assertions for the new contract.

Initialization, inspection, update, validation, templates, and managed-block scripts should remain unchanged unless implementation reveals a deterministic invariant they must enforce.

## Acceptance Scenarios

The implementation is acceptable when all of these behaviors are represented consistently in the Skill, references, documentation, and tests:

1. “开始实现” stays in the current task.
2. “新建一个任务做登录页” authorizes one clean user-visible task.
3. Harness does not create product, frontend, or backend tasks automatically.
4. A new independent task receives a compact project packet and does not inherit full chat history by default.
5. The originating task remains visible and does not monitor the new task.
6. “派生当前任务试另一个方案” may use native context forking because inheritance was explicit.
7. “换个任务继续整个项目” refreshes durable state before task creation and returns `HANDOFF_COMPLETE` when delivery succeeds.
8. Missing native capabilities return `READY_TO_HANDOFF` and a directly usable restart instruction.
9. New task creation does not create a Git branch or worktree by default.
10. Existing projects continue under Harness Protocol 2 without migration or new default files.

## Resolved Product Decisions

- Explicit user intent is required for user-visible task creation.
- New user-visible tasks are clean and independent by default.
- The originating task is retained and never automatically archived.
- The originating task does not monitor the new task by default.
- Fixed product, frontend, and backend task roles are not part of the default workflow.
- Native Codex task management is preferred; repository-first handoff remains the compatibility and recovery layer.
