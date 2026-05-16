# Git and GitHub Workflow

## Startup Checks

Run or inspect the equivalent of:

```powershell
git status
git branch --show-current
git remote -v
```

If the directory is not a Git repository, ask before initializing unless the user explicitly requested initialization.

## Initialization

Only initialize once:

```powershell
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin <repo-url>
git push -u origin main
```

If Git already exists, do not repeat `git init`.

## Branches

Use one branch per feature or fix:

- `feature/fe-dashboard-home`
- `feature/be-dashboard-summary`
- `fix/login-ci-failure`
- `experiment/editor-redesign`

Prefer worktrees when multiple conversations are editing in parallel.

## Worktrees

Branches are lightweight. Worktrees are real local folders and can consume significant disk space.

Use the main working tree for product discussion, documentation-only work, master/control review, merge, changelog updates, and small fixes that do not conflict with active work.

Use separate worktrees for non-trivial frontend/backend implementation, risky bugfixes, experiments, prototypes, and parallel work that may conflict.

The master/control conversation owns worktree decisions, audits, and cleanup. Before creating a worktree, check current status, existing worktrees, whether the task already has a branch/worktree, and whether the task is small enough to stay in the current working tree.

After merges, master/control should periodically list branches and worktrees, recommend what is active, merged, stale, or abandoned, and ask the user before deleting anything.

## PR Merge

Feature conversations prepare PR summaries. The master conversation handles review, verification, merge order, and changelog updates.

Before merge:

- Check diff.
- Check task docs.
- Run relevant test/lint/build commands.
- Confirm API contracts if frontend/backend both depend on the change.

After merge:

- Mark tasks `Done`.
- Update `docs/changelog.md`.
- Tell the user what merged and any residual risk.
