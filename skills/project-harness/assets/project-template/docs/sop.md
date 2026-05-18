# Project Development SOP

## Roles

- Master conversation: integration, Git, GitHub, PRs, merges, releases.
- Product conversation: requirements, architecture, task splitting, decisions.
- Frontend conversation: UI, components, pages, client behavior.
- Backend conversation: APIs, database, auth, server logic.
- Bugfix conversation: focused debugging and CI fixes.
- Experiment conversation: isolated prototypes and uncertain ideas.

## Source of Truth

Project knowledge must be stored in docs:

- `docs/product.md`
- `docs/architecture.md`
- `docs/api-contract.md`
- `docs/documentation.md`
- `docs/tasks.md`
- `docs/intent.md`
- `docs/migration.md`
- `docs/refresh.md`
- `docs/dispatch.md`
- `docs/triage.md`
- `docs/completion.md`
- `docs/acceptance.md`
- `docs/worktrees.md`
- `docs/single-conversation-harness.md`
- `docs/handovers/current-control-state.md`
- `docs/decisions.md`
- `docs/changelog.md`

Chat is for discussion and execution. Docs are for synchronization.

Use `docs/documentation.md` before starting work to decide which docs to read and update.

## Workflow

1. Default to single-conversation harness mode using `docs/single-conversation-harness.md`.
2. Discuss requirements in the master/control conversation or product mode.
3. Update product, task, decision, and contract docs before implementation when scope changes.
4. Implement small and medium tasks sequentially in the master/control conversation when practical.
5. Use specialist conversations, background agents, branches, or worktrees only when they reduce risk or unblock parallel work.
6. Choose same working tree, branch, or separate worktree using `docs/worktrees.md`.
7. Accept, reject, or conditionally accept delivered work using `docs/acceptance.md` when product acceptance is needed.
8. If rejected or conditionally accepted, write copy-ready rework instructions for the responsible conversation or execution mode.
9. If accepted, run technical review, tests/lint/build, and docs checks before merge or release.
10. Merge through GitHub PR when practical.
11. Update task status and changelog.
12. When the master/control conversation becomes too long, create or update the handoff packet using `docs/single-conversation-harness.md`.

## Short Commands

- Natural language such as "start this project with project-harness; this conversation is master" starts new project setup.
- Natural language such as "take over this existing project with project-harness; this conversation is master" starts migration using `docs/migration.md`.
- Natural language such as "sync the latest project-harness skill" refreshes conversation rules using `docs/refresh.md`.
- Natural language such as "use single-conversation harness mode" keeps product, control, implementation, and acceptance in one master/control conversation.
- Natural language such as "make a control handoff packet" outputs a migration summary for a new master/control conversation without editing files.
- Natural language such as "write the control handoff packet" updates `docs/handovers/current-control-state.md`.
- `New requirement: <description>` starts product clarification.
- `Requirement discussion is done. Please dispatch tasks.` tells product to update docs and output copy-ready task instructions.
- `Issue: <description>` lets the receiving conversation classify the issue using `docs/triage.md`.
- Similar natural-language expressions also count. Use `docs/intent.md` to map informal wording to the right workflow.

## Rules

- Do not directly merge feature work into `main`.
- Do not duplicate `git init`.
- Do not let multiple conversations casually edit the same file.
- Before starting work, use `docs/documentation.md` to identify relevant docs.
- API changes must update `docs/api-contract.md`.
- Architecture decisions must update `docs/decisions.md`.
- Natural-language intent recognition must use `docs/intent.md`.
- Existing project migration must use `docs/migration.md`.
- Harness refresh must use `docs/refresh.md`.
- Requirement dispatch must use `docs/dispatch.md`.
- Issue triage must use `docs/triage.md`.
- Feature completion must use `docs/completion.md`.
- Product acceptance must use `docs/acceptance.md` when a task needs review.
- Worktree and branch decisions must use `docs/worktrees.md`.
- Single-conversation mode must use `docs/single-conversation-harness.md`.
- Product/documentation work defaults to the master/control conversation and main working tree; separate conversations/worktrees are for non-trivial implementation, risky fixes, experiments, or parallel work.
- Master/control owns worktree audits and cleanup; do not delete worktrees or branches without explicit user approval.
- Accepted work must include copy-ready next-step instructions for master/control.
- Rejected work must include failed points, responsible conversation, docs to update, and copy-ready rework instructions.
- Every task should have an ID, owner, branch, status, dependencies, and acceptance criteria.
