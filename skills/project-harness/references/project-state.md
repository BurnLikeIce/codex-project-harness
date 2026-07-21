# Durable Project State

## Source-of-Truth Rules

Prefer an existing project-specific document over a generated template. When multiple files overlap, identify one canonical source and link to it from `HARNESS.md`; do not silently merge or rewrite competing documents.

Use `HARNESS.md` as a map, not an encyclopedia. Keep deep product, architecture, contract, security, deployment, or operational knowledge in focused files that already fit the project.

## Task Record

A durable task should contain only the state needed to resume and govern the work:

- stable identifier when the project already uses IDs;
- outcome and scope;
- status and owner or control context;
- durable constraints and linked decisions;
- acceptance criteria;
- dependencies or coordination boundaries;
- evidence and next action.

Do not require IDs for trivial isolated work. Do not encode implementation narration in the task ledger when Git, a plan, or test output already holds it.

## Decision Record

Record:

- the decision;
- context and reason;
- alternatives only when they matter later;
- consequences and affected contracts;
- status and linked task.

Do not turn routine implementation choices into permanent decisions.

## Update Timing

- After discussion commits a meaningful change, update the task and decision state before independent execution begins.
- During execution, update durable state only when scope, ownership, dependencies, decisions, or next actions change.
- Before acceptance or handoff, refresh criteria, evidence, unresolved risks, and next action.
- After acceptance, integration, release, supersession, or rollback, close the loop in the durable record.

## Conditional Documents

Create a focused document when the information is durable, shared, and too substantial for the task or decision ledger. Common examples are product specifications, architecture maps, API contracts, data schemas, security boundaries, deployment procedures, test strategies, release plans, and control handoffs.

Do not create empty placeholders for documents the project does not need.
