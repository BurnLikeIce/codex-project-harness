# Coordination

## Default

Keep ordinary work in one control context. Coordination exists to reduce risk, preserve ownership, or gain meaningful parallelism, not to mirror an organization chart.

## One Coordinator

Each governed task has one active coordinator responsible for:

- the task contract and current state;
- decomposition and ownership;
- resolving scope or contract questions;
- integration order;
- final evidence and acceptance routing.

Execution units may implement and report results, but they do not independently expand product scope or change shared contracts without returning the decision to the coordinator.

## Identifier Ownership

The active project coordinator owns allocation of project-wide task and decision identifiers. It must reserve durable records before parallel dispatch whenever possible. Execution units use the assigned task reference and return unnumbered proposals for newly discovered durable work; they do not race to allocate the next global identifier.

## Execution Unit Contract

Provide each independent unit with:

- task or parent-task reference;
- exact outcome and boundaries;
- relevant sources of truth;
- allowed and prohibited scope when overlap is risky;
- dependencies and assumptions;
- required verification evidence;
- completion return format.

The contract must stand alone. Do not require the user to copy a long conversation transcript.

## Branches and Worktrees

Use isolation when concurrent or risky writes justify it. Record branch or worktree ownership only while it affects integration. Avoid creating a worktree for every conversation or every small task.

Before integration, verify the expected base, changed scope, tests, unresolved risks, and integration order. Remove worktrees and branches only after their work is integrated or explicitly abandoned and cleanup is authorized.

## Handoff

Before moving control to another conversation, update durable tasks, decisions, evidence, and the project map. In most projects, those repository sources are the handoff packet.

Create or update a focused handoff file such as `docs/handovers/current-control-state.md` only when important unresolved context cannot fit the existing ledgers. Map that file from `HARNESS.md`, and remove or supersede it after the receiving context absorbs the state.

The handoff state must cover:

- current objective and accepted baseline;
- active tasks, owners, branches, and worktrees;
- settled decisions and protected constraints;
- verification and release state;
- unresolved questions and exact next action.

Return `READY_TO_HANDOFF` and one directly usable restart instruction, localized to the user when practical. A valid generic instruction is:

> Continue this project. Read `AGENTS.md`, `HARNESS.md`, and the current task and decision state first, then resume the recorded next action.

The receiving context should be able to resume from repository files and this concise packet without reconstructing old chat history.
