---
name: project-harness
description: Use when starting, migrating, or operating a software project with Codex project discipline: one master/control conversation, optional single-conversation mode, optional specialist conversations, shared docs, task IDs, acceptance, handoff/migration packets, worktrees, Git/GitHub, or natural-language workflow intent. Also use for Chinese requests such as 启动项目, 旧项目接管, 本对话作为主控, 单主对话, 多对话协作, 主控迁移包, 工作树管理.
---

# Project Harness

Use this skill to start or normalize a project so Codex can collaborate through shared files, task discipline, Git branches, and GitHub PRs. The default mode is a long-lived master/control conversation. Specialist conversations and worktrees are optional tools, not mandatory ceremony.

For Chinese-language projects, prefer the `.zh-CN.md` prompt and SOP templates when present.

## Core Model

- Treat the first project conversation as the **master/control conversation** unless the user says otherwise.
- Prefer **single-conversation harness mode** for ordinary work: product discussion, task planning, implementation, acceptance, and release decisions can happen in one master/control conversation with explicit mode switches.
- Use specialist conversations only when they reduce risk or unblock parallel work.
- Use project docs as the source of truth. Chat is for discussion and execution; docs are for synchronization.
- Use Git branches or worktrees when isolation is useful; do not create worktrees by default for every task.
- Use GitHub Issues/PRs for reviewable collaboration when the project has a GitHub remote.
- Use a control handoff packet when the master/control conversation becomes too long or must migrate to a new conversation.
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
   - `docs/single-conversation-harness.md`
   - `docs/handovers/current-control-state.md`
   - `prompts/master.md`
   - `prompts/master.zh-CN.md` when the user wants Chinese prompts
   - `.github/pull_request_template.md`
3. If harness files are missing, copy the bundled templates from `assets/project-template/` into the project.
4. If Git is missing, ask whether to initialize it unless the user explicitly requested initialization.
5. If Git exists, check branch, status, and remotes.
6. Tell the user that the current conversation is now the master/control conversation.
7. Tell the user the default mode is a single master/control conversation, and list optional specialist conversations only when useful.

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
- `docs/single-conversation-harness.md`
- `docs/handovers/current-control-state.md`
- `docs/decisions.md`

For ordinary work, keep the user in the master/control conversation. When specialist conversations are useful, give the user short handoff instructions such as:

```text
Frontend: read prompts/frontend.md and implement FE-001 from docs/tasks.md.
Backend: read prompts/backend.md and implement BE-001 from docs/tasks.md.
```

Do not make the user copy long chat transcripts between conversations. Use task docs or a control handoff packet instead.

## Completion Output

After initialization, report:

- Files created or already present.
- Git/GitHub status.
- Which conversation this is now.
- Whether the project should stay in single-conversation mode or use optional specialist conversations.
- Exact short prompts to paste into any new conversation only when those conversations are actually needed.
