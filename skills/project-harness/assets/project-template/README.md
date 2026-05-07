# Codex Project Harness

A reusable project harness for coordinating multiple Codex conversations in one software project.

## What It Does

- Turns the first project conversation into the master/control conversation.
- Creates shared project docs and role prompts.
- Provides task completion templates for product acceptance requests.
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
2. Use the product conversation to update product, architecture, API, task, acceptance, and decision docs.
3. Use frontend/backend conversations to implement assigned task IDs and output task deliveries.
4. Use the product conversation to accept, reject, or conditionally accept delivered work.
5. Use the master conversation to review, verify, and merge accepted work.

## Chinese

Chinese instructions are available in `README.zh-CN.md`, `docs/sop.zh-CN.md`, and `prompts/*.zh-CN.md`.
