# Codex Project Harness

A bilingual Codex skill for managing software projects with one master/control conversation, optional specialist conversations, shared docs, task IDs, Git branches, worktrees, and GitHub PR workflows.

This project is an experimental workflow template for Codex. It helps you start a new project, migrate an existing project, keep ordinary work in one long-lived master/control conversation, and use specialist conversations only when they are actually useful.

## What It Does

- Turns the first project conversation into the master/control conversation.
- Supports single-conversation harness mode for product discussion, implementation, acceptance, and release decisions in one thread.
- Provides a control handoff packet template for migrating a long-running master conversation to a new one.
- Creates shared project docs for product, architecture, API contracts, tasks, decisions, and changelog.
- Provides role prompts for master, product, frontend, backend, bugfix, and experiment conversations.
- Standardizes Git/GitHub branch, worktree, PR, review, and merge workflows.
- Includes English and Chinese templates.

## Repository Structure

```text
codex-project-harness/
  README.md
  README.zh-CN.md
  LICENSE
  skills/
    project-harness/
      SKILL.md
      agents/
      assets/
      references/
      scripts/
```

## Install

Copy this folder:

```text
skills/project-harness
```

to your local Codex skills directory:

```text
~/.codex/skills/project-harness
```

Then restart Codex.

The final path should look like this:

```text
~/.codex/skills/project-harness/SKILL.md
```

## Install Without Terminal on macOS

1. Download this repository as a ZIP file.
2. Unzip it.
3. Open Finder.
4. Press `Command + Shift + G`.
5. Enter:

```text
~/.codex/skills
```

6. Drag the `project-harness` folder from `skills/project-harness` into that directory.
7. Restart Codex.

Make sure the final path is:

```text
~/.codex/skills/project-harness/SKILL.md
```

not:

```text
~/.codex/skills/project-harness/project-harness/SKILL.md
```

## Usage

In the first conversation for a new project, say:

```text
Please use the project-harness skill to start this new project.
From now on, this conversation is the master/control conversation.
Project name: <your project name>
I use Git and GitHub.
```

By default, keep the project in single-conversation harness mode. Create frontend/backend/bugfix conversations only when parallelism or isolation is useful.

For an existing project, say:

```text
Please use the project-harness skill to migrate this existing project into the project harness workflow.
Do not overwrite existing docs. First inspect the project and propose a migration plan.
From now on, this conversation is the master/control conversation.
```

## Conversation Model

- Default: one long-lived master/control conversation switches between product, control, implementation, acceptance, release, and migration modes.
- Optional product/frontend/backend/bugfix/experiment conversations can still be created for larger, risky, or parallel work.
- Worktrees are optional isolation tools, not the default for every task.
- When a master/control conversation gets too long, use `docs/handovers/current-control-state.md` to migrate to a new master/control conversation.

## Core Rule

Chat is for discussion and execution. Docs are for synchronization.

When product or architecture decisions are made, update project docs first. If specialist conversations are needed, hand off short task IDs such as:

```text
Frontend: read prompts/frontend.md and implement FE-001 from docs/tasks.md.
Backend: read prompts/backend.md and implement BE-001 from docs/tasks.md.
```

## License

MIT
