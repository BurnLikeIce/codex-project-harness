# Task Completion Template

Use this document when a frontend, backend, bugfix, experiment, or other implementation conversation finishes an assigned task and needs product acceptance.

The implementation conversation is responsible for explaining what changed and what was verified. The product conversation is responsible for acceptance decisions and rework instructions.

## Completion Rule

Every implementation conversation must finish with a copy-ready product acceptance request.

Do not assume the task has screenshots, demos, APIs, UI, or tests. Use only the sections that apply, and write `Not applicable` when a section does not apply.

## Output Format

```md
## Task Delivery: <Task ID>

Status: Requesting product acceptance

Responsible Conversation: Frontend / Backend / Bugfix / Experiment / Other

Task Source:
- Task doc: `docs/tasks.md`
- Task ID: <Task ID>

Completed Work:
-

Acceptance Criteria Mapping:
- <Acceptance criterion>: <completion status or evidence>

Change Summary:
- Code changes:
- Behavior changes:
- Documentation changes:
- Configuration changes:
- Data/API changes:

Verification:
- Completed:
  - <command/check/result>
- Not completed:
  - <reason>

Known Issues / Risks:
-

Questions For Product:
-

Copy-Ready Product Acceptance Request:

```text
Please accept <Task ID>.

This is the delivery from the <Responsible Conversation> conversation.

Completed work:
-

Acceptance criteria mapping:
-

Change summary:
-

Verification:
-

Known issues / risks:
-

Questions for product:
-
```
```

## Notes

- Do not ask the product conversation to produce rework instructions here. That rule belongs in `docs/acceptance.md`.
- If product accepts the task, product hands it to the master conversation for technical review and merge.
- If product rejects or conditionally accepts the task, product returns copy-ready rework instructions to the responsible conversation.
