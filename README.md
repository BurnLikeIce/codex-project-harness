# Codex Project Harness

A bilingual Codex skill for managing multi-conversation software projects with shared docs, role prompts, Git branches, and GitHub PR workflows.

This project is an experimental workflow template for Codex. It helps you start a new project, migrate an existing project, and coordinate multiple Codex conversations without copying long chat transcripts between them.

## What It Does

- Turns the first project conversation into the master/control conversation.
- Creates shared project docs for product, architecture, API contracts, tasks, decisions, and changelog.
- Provides role prompts for master, product, frontend, backend, bugfix, and experiment conversations.
- Standardizes Git/GitHub branch, PR, review, and merge workflows.
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

For an existing project, say:

```text
Please use the project-harness skill to migrate this existing project into the multi-conversation workflow.
Do not overwrite existing docs. First inspect the project and propose a migration plan.
From now on, this conversation is the master/control conversation.
```

## Conversation Model

- Master/control conversation: Git, GitHub, PRs, merges, releases, and project-wide coordination.
- Product/architecture conversation: requirements, architecture, task splitting, and decisions.
- Frontend conversation: pages, components, styling, interaction, and client behavior.
- Backend conversation: APIs, database, auth, server logic, and backend tests.
- Bugfix/CI conversation: focused debugging and failing checks.
- Experiment conversation: isolated prototypes and uncertain ideas.

## Core Rule

Chat is for discussion and execution. Docs are for synchronization.

When product or architecture decisions are made, update project docs first, then hand off short task IDs such as:

```text
Frontend: read prompts/frontend.md and implement FE-001 from docs/tasks.md.
Backend: read prompts/backend.md and implement BE-001 from docs/tasks.md.
```

## License

MIT
