---
name: project-harness
description: Initialize and operate a reusable multi-conversation Codex project harness. Use when the user wants to start a new software project, migrate or take over an existing project, turn the first/current conversation into the master/control conversation, create a repeatable project SOP, set up shared docs/prompts/GitHub templates, coordinate product/frontend/backend/bugfix/experiment conversations, recognize natural-language workflow intent, or standardize Git/GitHub branch and PR workflows. Also use for Chinese requests such as 启动新项目, 旧项目接管, 迁移已有项目, 本对话作为主控, 项目主控对话, 多对话协作, 项目开发SOP, 前后端对话协同, 产品对话同步, GitHub PR合并流程.
---

# Project Harness

Use this skill to start or normalize a project so multiple Codex conversations can collaborate through shared files, Git branches, and GitHub PRs.

For Chinese-language projects, prefer the `.zh-CN.md` prompt and SOP templates when present.

## Core Model

- Treat the first project conversation as the **master/control conversation** unless the user says otherwise.
- Use project docs as the source of truth. Chat is for discussion and execution; docs are for synchronization.
- Use Git branches or worktrees for feature conversations.
- Use GitHub Issues/PRs for reviewable collaboration when the project has a GitHub remote.
- Do not repeatedly initialize Git. Check first.

## Quick Start Workflow

1. Inspect the current directory.
2. Check whether the project already has:
   - `.git`
   - `docs/sop.md`
   - `docs/sop.zh-CN.md` when the user wants Chinese docs
   - `docs/documentation.md`
   - `docs/tasks.md`
   - `docs/intent.md`
   - `docs/migration.md`
   - `docs/dispatch.md`
   - `docs/triage.md`
   - `docs/completion.md`
   - `docs/acceptance.md`
   - `docs/worktrees.md`
   - `prompts/master.md`
   - `prompts/master.zh-CN.md` when the user wants Chinese prompts
   - `.github/pull_request_template.md`
3. If harness files are missing, copy the bundled templates from `assets/project-template/` into the project.
4. If Git is missing, ask whether to initialize it unless the user explicitly requested initialization.
5. If Git exists, check branch, status, and remotes.
6. Tell the user that the current conversation is now the master/control conversation.
7. Output the next conversations to create and the prompt file each should use.

Prefer running the platform script for template installation:

- Windows: `scripts/init_project_harness.ps1`
- macOS/Linux: `scripts/init_project_harness.sh`

Use the matching `check_project` script to inspect the project state.

## Bundled Resources

- `assets/project-template/`: files to copy into a new project.
- `references/workflow.md`: complete project SOP.
- `references/conversation-roles.md`: role boundaries and handoff rules.
- `references/git-github.md`: Git/GitHub branch and PR workflow.
- `scripts/init_project_harness.ps1`: install harness files into a project directory on Windows.
- `scripts/check_project.ps1`: inspect Git, docs, prompts, and GitHub template readiness on Windows.
- `scripts/init_project_harness.sh`: install harness files into a project directory on macOS/Linux.
- `scripts/check_project.sh`: inspect Git, docs, prompts, and GitHub template readiness on macOS/Linux.

Load only the reference file needed for the user request.

## Conversation Handoff Rule

When product/architecture decisions are made, update the project docs first:

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
- `docs/worktrees.md`
- `docs/decisions.md`

Then give the user short handoff instructions such as:

```text
Frontend: read prompts/frontend.md and implement FE-001 from docs/tasks.md.
Backend: read prompts/backend.md and implement BE-001 from docs/tasks.md.
```

Do not make the user copy long chat transcripts between conversations.

## Completion Output

After initialization, report:

- Files created or already present.
- Git/GitHub status.
- Which conversation this is now.
- Which conversations to create next.
- Exact short prompts to paste into each new conversation.
