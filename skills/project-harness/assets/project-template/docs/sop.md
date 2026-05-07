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
- `docs/acceptance.md`
- `docs/decisions.md`
- `docs/changelog.md`

Chat is for discussion and execution. Docs are for synchronization.

## Workflow

1. Product conversation discusses requirements.
2. Product conversation updates docs and tasks.
3. Master conversation reviews task split.
4. Frontend/backend conversations work on assigned task IDs.
5. Each feature uses its own branch or worktree.
6. Feature conversations update docs and commit changes.
7. Master conversation reviews branch or PR.
8. Product conversation accepts, rejects, or conditionally accepts completed work when product fit matters.
9. If rejected or conditionally accepted, product conversation writes rework instructions and handoff notes.
10. Master runs tests, lint, and build.
11. Master merges through GitHub PR when practical.
12. Master updates task status and changelog.

## Rules

- Do not directly merge feature work into `main`.
- Do not duplicate `git init`.
- Do not let multiple conversations casually edit the same file.
- API changes must update `docs/api-contract.md`.
- Architecture decisions must update `docs/decisions.md`.
- Product acceptance must use `docs/acceptance.md` when a task needs review.
- Rejected work must include owner, task ID, required changes, docs to update, and next handoff.
- Every task should have an ID, owner, branch, status, dependencies, and acceptance criteria.
