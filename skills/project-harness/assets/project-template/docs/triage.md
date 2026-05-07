# Issue Triage

Use this document when the user reports a problem with a short message such as:

```text
Issue: <description>
```

The receiving conversation must classify the issue and either handle it, record it, or produce a copy-ready escalation instruction.

## Routing Rules

- Clear, small implementation issue in a known area: route to the responsible implementation conversation, such as frontend or backend.
- Unclear product behavior, interaction rule, scope, or acceptance criteria: route to product/architecture.
- Unknown root cause, cross-stack issue, regression, failing test, build, CI, or deployment problem: route to bugfix/CI or master.
- Branch, merge, PR, release, environment, or deployment coordination problem: route to master/control.

## Recording Rule

Do not let fixes disappear from project history.

- If the issue belongs to an existing task, record it under that task in `docs/tasks.md`.
- If it is a small obvious fix outside any task, create a small task entry such as `BUG-001` or `FE-001`.
- If it is ambiguous or large, do not implement immediately. Produce a copy-ready instruction for the product or bugfix conversation to clarify/split it.

## Receiving Conversation Behavior

When a conversation receives `Issue: <description>`, it should output one of:

```text
Classification: Direct fix
Reason:
Task record:
Next step:
```

```text
Classification: Needs product clarification
Reason:
Copy-ready instruction for product conversation:
...
```

```text
Classification: Needs bugfix investigation
Reason:
Copy-ready instruction for bugfix conversation:
...
```

```text
Classification: Needs master coordination
Reason:
Copy-ready instruction for master conversation:
...
```
