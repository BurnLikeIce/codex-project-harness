# Existing Project Migration

Use this document when a conversation is asked to adopt, migrate, normalize, or take over an existing project with project-harness.

The short user prompt may be as simple as:

```text
Use project-harness to take over this existing project. This conversation is master. First inspect and propose a migration plan. Do not overwrite existing docs.
```

Similar natural-language requests also count.

## Migration Rules

- Treat the current conversation as the master/control conversation unless the user says otherwise.
- Do not overwrite, delete, or rewrite existing docs.
- Do not repeat `git init`.
- Do not directly change business code during migration.
- Prefer index files, links, and additive sections over replacing existing docs.
- If existing docs conflict with harness templates, preserve existing docs and propose a merge plan.
- First inspect and propose a plan. Wait for user approval before large file changes.

## Inspection Checklist

Check:

- Current directory structure.
- Git repository status, branch, working tree, remote, default branch.
- Existing README, docs, `.github`, prompts, deployment, test, design, and operations docs.
- Existing GitHub issue/PR workflow if visible.
- Current project phase: clarification, development, acceptance, merge, release, or maintenance.

Classify existing docs as:

- Product
- Architecture
- API
- Tasks
- Decisions
- Deployment
- Operations
- Design
- Testing
- Acceptance
- Release

## Harness Gap Analysis

Compare current project against the latest harness standard files:

- `HARNESS.md`
- `README.md` / `README.zh-CN.md`
- `docs/sop.md` / `docs/sop.zh-CN.md`
- `docs/product.md`
- `docs/architecture.md`
- `docs/api-contract.md`
- `docs/tasks.md`
- `docs/intent.md` / `docs/intent.zh-CN.md`
- `docs/migration.md` / `docs/migration.zh-CN.md`
- `docs/dispatch.md` / `docs/dispatch.zh-CN.md`
- `docs/triage.md` / `docs/triage.zh-CN.md`
- `docs/completion.md` / `docs/completion.zh-CN.md`
- `docs/acceptance.md` / `docs/acceptance.zh-CN.md`
- `docs/decisions.md`
- `docs/changelog.md`
- `prompts/*.md` / `prompts/*.zh-CN.md`
- `.github/pull_request_template.md`
- `.github/ISSUE_TEMPLATE/*`

For each file, decide whether it is present, missing, replaced by an existing equivalent, should be added, or should be represented by an index link.

## Migration Plan Output

Before editing, output:

```md
## Migration Plan

Current Status:
-

Existing Docs:
- <file>: <category and role>

Harness Gaps:
- Missing:
- Covered by existing docs:
- Add as index/link:
- Add as new template:

Proposed Changes:
- Keep unchanged:
- Add:
- Append section:
- Create index:

Workflow Integration:
- Intent recognition:
- Requirement dispatch:
- Issue triage:
- Task completion:
- Product acceptance:
- Master review/merge:

Suggested Conversations:
- Product:
- Frontend:
- Backend:
- Bugfix:
- Experiment:

Risks / Questions:
-
```

## After Approval

After user approval:

- Add missing harness files without overwriting existing docs.
- Create `HARNESS.md` or `docs/index.md` to point to existing source-of-truth docs.
- Add or update `prompts/` role files.
- Update `docs/tasks.md` with known active tasks when safe.
- Keep changes small and reviewable.
- Report files changed, Git status, source-of-truth docs, suggested next conversations, and unresolved risks.
