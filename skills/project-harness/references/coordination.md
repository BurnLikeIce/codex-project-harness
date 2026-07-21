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

Before moving control to another conversation, update durable state and provide:

- current objective and accepted baseline;
- active tasks, owners, branches, and worktrees;
- settled decisions and protected constraints;
- verification and release state;
- unresolved questions and exact next action.

The receiving context should be able to resume from repository files and this concise packet without reconstructing old chat history.
