# Documentation Map

Use this document before starting work to decide which project docs to read and which docs may need updates.

Not every project needs every optional document. Every task should still identify its relevant source-of-truth docs before implementation.

## Required Core Docs

- `docs/product.md`: product goals, users, scope, user stories, lightweight PRD.
- `docs/architecture.md`: technical architecture, module boundaries, data flow.
- `docs/api-contract.md`: API contracts, request/response shapes, integration assumptions.
- `docs/tasks.md`: task IDs, owners, branches, status, dependencies, acceptance criteria.
- `docs/decisions.md`: important decisions and rationale.
- `docs/changelog.md`: notable merged changes and release notes.

## Harness Workflow Docs

- `docs/sop.md`: project collaboration workflow.
- `docs/intent.md`: natural-language intent recognition.
- `docs/migration.md`: existing project migration/takeover.
- `docs/refresh.md`: syncing latest harness rules.
- `docs/dispatch.md`: requirement clarification and task dispatch.
- `docs/triage.md`: issue routing and escalation.
- `docs/completion.md`: implementation task delivery format.
- `docs/acceptance.md`: product acceptance and rework format.
- `docs/worktrees.md`: branch/worktree policy, when to isolate work, and cleanup rules.

## Optional Docs By Project Need

- `docs/data-model.md`: database schema, entities, relationships, migrations.
- `docs/business-rules.md`: complex domain rules and edge cases.
- `docs/deployment.md`: deployment environments, commands, configuration.
- `docs/testing.md`: test strategy, manual QA, fixtures, coverage expectations.
- `docs/design.md`: UI/UX design notes, interaction rules, design references.
- `docs/security.md`: permissions, auth, threat model, sensitive data handling.
- `docs/operations.md`: monitoring, runbooks, support procedures.

## Before Starting A Task

Every conversation should ask:

- Which docs define the requirement?
- Which docs define the technical contract?
- Which docs will this task change?
- Does this need product acceptance?
- Does this need master review/merge?

## Role Guide

Master/control:

- Read: `docs/sop.md`, `docs/documentation.md`, `docs/tasks.md`, `docs/worktrees.md`, `docs/decisions.md`, `docs/changelog.md`.
- Update: `docs/tasks.md`, `docs/changelog.md`, `docs/decisions.md`, harness docs when explicitly refreshing project files.

Product/architecture:

- Read: `docs/documentation.md`, `docs/product.md`, `docs/tasks.md`, `docs/decisions.md`.
- Also read `docs/api-contract.md` and `docs/architecture.md` when the requirement affects system behavior.
- Update: `docs/product.md`, `docs/tasks.md`, `docs/decisions.md`, and relevant contract/architecture docs.

Frontend:

- Read: `docs/documentation.md`, `docs/tasks.md`, `docs/product.md`, `docs/api-contract.md`.
- Also read `docs/design.md` when UI/UX details matter.
- Update: `docs/tasks.md` and relevant UI/design notes when behavior changes.

Backend:

- Read: `docs/documentation.md`, `docs/tasks.md`, `docs/architecture.md`, `docs/api-contract.md`.
- Also read `docs/data-model.md`, `docs/security.md`, or `docs/business-rules.md` when relevant.
- Update: `docs/api-contract.md`, `docs/tasks.md`, and relevant data/security/business docs.

Bugfix/CI:

- Read: `docs/documentation.md`, `docs/tasks.md`, and the docs related to the failing area.
- Update: `docs/tasks.md`, `docs/decisions.md`, or `docs/testing.md` when the fix changes expectations.

Experiment:

- Read: `docs/documentation.md`, `docs/product.md`, `docs/architecture.md`, and the relevant task.
- Update: `docs/decisions.md` when the experiment leads to a project decision.
