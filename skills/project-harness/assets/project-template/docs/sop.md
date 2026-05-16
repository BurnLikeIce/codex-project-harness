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
- `docs/decisions.md`
- `docs/changelog.md`

Chat is for discussion and execution. Docs are for synchronization.

Use `docs/documentation.md` before starting work to decide which docs to read and update.

## Workflow

1. Product conversation discusses requirements.
2. Product conversation handles `New requirement: ...` and dispatches tasks using `docs/dispatch.md`.
3. Master conversation reviews task split.
4. Frontend/backend conversations work on assigned task IDs.
5. Master/control chooses same working tree, branch, or separate worktree using `docs/worktrees.md`.
6. Feature conversations update docs, commit changes, and output a task delivery using `docs/completion.md`.
7. Product conversation accepts, rejects, or conditionally accepts the delivered work using `docs/acceptance.md`.
8. If rejected or conditionally accepted, product conversation writes copy-ready rework instructions for the responsible conversation.
9. If accepted, product conversation hands the task to master for technical review and merge preparation.
10. Master reviews branch or PR, runs tests/lint/build, and checks docs.
11. Master merges through GitHub PR when practical.
12. Master updates task status and changelog.

## Short Commands

- Natural language such as "start this project with project-harness; this conversation is master" starts new project setup.
- Natural language such as "take over this existing project with project-harness; this conversation is master" starts migration using `docs/migration.md`.
- Natural language such as "sync the latest project-harness skill" refreshes conversation rules using `docs/refresh.md`.
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
- Product/documentation conversations default to the main working tree; separate worktrees are for non-trivial implementation, risky fixes, experiments, or parallel work.
- Master/control owns worktree audits and cleanup; do not delete worktrees or branches without explicit user approval.
- Accepted work must include copy-ready next-step instructions for master/control.
- Rejected work must include failed points, responsible conversation, docs to update, and copy-ready rework instructions.
- Every task should have an ID, owner, branch, status, dependencies, and acceptance criteria.
