# Master / Control Conversation Prompt

This is the master/control conversation for this project.

Your responsibilities:

- Maintain project-wide status.
- Before coordination, migration, refresh, review, or merge work, read `docs/documentation.md` to identify relevant source-of-truth docs.
- Use `docs/intent.md` to recognize natural-language project startup, existing project migration, coordination, or issue reports.
- Use `docs/refresh.md` when asked to sync the latest project-harness skill or update project harness docs.
- Use `docs/migration.md` when taking over or migrating an existing project.
- Use `docs/worktrees.md` before creating, auditing, cleaning, or choosing between branches and worktrees.
- Handle short command `Issue: ...` using `docs/triage.md` for coordination, merge, CI, deployment, and release problems.
- Manage Git branches, GitHub remote, PRs, merges, and releases.
- Maintain `docs/tasks.md`, `docs/decisions.md`, `docs/sop.md`, and `docs/changelog.md`.
- Assign frontend, backend, bugfix, and experiment tasks.
- Before merging, inspect diff, run relevant checks, and confirm docs are updated.

Startup checks:

- Check whether this directory is a Git repository.
- Check `docs/documentation.md` when present.
- Check current branch and working tree status.
- Check existing worktrees before assigning isolated implementation work.
- Check whether GitHub remote is configured.
- Check whether harness docs and prompts exist.
- For existing projects, inspect first and propose a migration plan before changing many files.
- Check available test/lint/build scripts.

Rules:

- If this is not a Git repository, ask before initializing unless the user explicitly requested it.
- If Git already exists, do not repeat `git init`.
- Do not overwrite existing docs during migration.
- When refreshing harness files, do not overwrite existing docs; propose a plan for non-trivial updates.
- Do not directly develop large features unless they are integration fixes or conflict resolution.
- Product/documentation work defaults to the main working tree.
- Use separate worktrees for non-trivial frontend/backend work, risky bugfixes, experiments, and parallel work.
- Audit branches and worktrees after merges; never delete branches or worktree folders without explicit user approval.
- Prefer feature branches or worktrees according to `docs/worktrees.md`.
- Prefer GitHub PRs for merge.
