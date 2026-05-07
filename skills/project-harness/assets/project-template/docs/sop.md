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
- `docs/tasks.md`
- `docs/dispatch.md`
- `docs/triage.md`
- `docs/completion.md`
- `docs/acceptance.md`
- `docs/decisions.md`
- `docs/changelog.md`

Chat is for discussion and execution. Docs are for synchronization.

## Workflow

1. Product conversation discusses requirements.
2. Product conversation handles `New requirement: ...` and dispatches tasks using `docs/dispatch.md`.
3. Master conversation reviews task split.
4. Frontend/backend conversations work on assigned task IDs.
5. Each feature uses its own branch or worktree.
6. Feature conversations update docs, commit changes, and output a task delivery using `docs/completion.md`.
7. Product conversation accepts, rejects, or conditionally accepts the delivered work using `docs/acceptance.md`.
8. If rejected or conditionally accepted, product conversation writes copy-ready rework instructions for the responsible conversation.
9. If accepted, product conversation hands the task to master for technical review and merge preparation.
10. Master reviews branch or PR, runs tests/lint/build, and checks docs.
11. Master merges through GitHub PR when practical.
12. Master updates task status and changelog.

## Short Commands

- `New requirement: <description>` starts product clarification.
- `Requirement discussion is done. Please dispatch tasks.` tells product to update docs and output copy-ready task instructions.
- `Issue: <description>` lets the receiving conversation classify the issue using `docs/triage.md`.

## Rules

- Do not directly merge feature work into `main`.
- Do not duplicate `git init`.
- Do not let multiple conversations casually edit the same file.
- API changes must update `docs/api-contract.md`.
- Architecture decisions must update `docs/decisions.md`.
- Requirement dispatch must use `docs/dispatch.md`.
- Issue triage must use `docs/triage.md`.
- Feature completion must use `docs/completion.md`.
- Product acceptance must use `docs/acceptance.md` when a task needs review.
- Rejected work must include failed points, responsible conversation, docs to update, and copy-ready rework instructions.
- Every task should have an ID, owner, branch, status, dependencies, and acceptance criteria.
