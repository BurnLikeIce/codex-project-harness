# Codex Project Harness

A reusable project harness for coordinating multiple Codex conversations in one software project.

## What It Does

- Turns the first project conversation into the master/control conversation.
- Creates shared project docs and role prompts.
- Provides task completion templates for product acceptance requests.
- Provides short-command requirement dispatch and issue triage rules.
- Maps natural-language requests to the right workflow, so exact commands are optional.
- Supports new project startup and existing project takeover with short natural-language prompts.
- Provides acceptance and rework templates for product reviews.
- Coordinates product, frontend, backend, bugfix, and experiment conversations.
- Standardizes Git/GitHub branch and PR workflows.

## Install This Harness Into a Project

Use the `project-harness` skill from a project directory and ask:

```text
Please use project-harness to start this project.
From now on, this conversation is the master/control conversation.
```

## Conversation Flow

1. Use the master conversation to install/check the harness.
2. For existing projects, ask the master conversation to take over the project with project-harness and propose a migration plan.
3. Use `New requirement: ...` or similar natural language in the product conversation to clarify work.
4. Use `Requirement discussion is done. Please dispatch tasks.` to create task instructions.
5. Use `Issue: ...` or similar natural language in the most relevant conversation; it will either handle or escalate the issue.
6. Use frontend/backend conversations to implement assigned task IDs and output task deliveries.
7. Use the product conversation to accept, reject, or conditionally accept delivered work.
8. Use the master conversation to review, verify, and merge accepted work.

## Chinese

Chinese instructions are available in `README.zh-CN.md`, `docs/sop.zh-CN.md`, and `prompts/*.zh-CN.md`.
