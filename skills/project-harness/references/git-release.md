# Git, Integration, and Release

## Inspect First

Before changing repository state, inspect the current branch, working tree, remotes, existing worktrees, and protected project or release rules. Never repeat `git init` when `.git` already exists.

## Local Work

Local inspection, in-scope edits, and non-destructive verification may proceed when the user requested implementation. A branch or worktree is optional and should have a concrete isolation or review benefit.

Do not discard unrelated or user-authored changes. Keep commits focused when commits are authorized.

## Integration

Before merge or equivalent integration, verify:

- correct base and task ownership;
- accepted scope and evidence;
- shared contracts and generated artifacts;
- required tests and checks;
- known conflicts and integration order;
- rollback or recovery expectations when risk warrants them.

## Remote and Release Boundaries

Treat push, pull-request creation, merge, tag publication, package publication, deployment, release, and remote deletion as external actions. Perform them only when explicitly requested or clearly authorized by established project policy.

Acceptance does not automatically authorize release. A successful local result may still require integration, product acceptance, environment verification, or release approval.

## Cleanup

List merged, abandoned, or stale branches and worktrees before cleanup. Delete only items whose ownership and integration state are known and whose cleanup is authorized.
