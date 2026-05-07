# Requirement Dispatch

Use this document in the product/architecture conversation.

## Short Commands

Start requirement clarification:

```text
New requirement: <description>
```

End discussion and dispatch work:

```text
Requirement discussion is done. Please dispatch tasks.
```

## Product Conversation Behavior

During clarification:

- Ask concise questions.
- Do not start implementation.
- Identify product scope, boundaries, acceptance criteria, and affected roles.

When dispatching:

- Update relevant docs.
- Create or update task IDs in `docs/tasks.md`.
- State dependencies.
- Output copy-ready instructions for the target conversations.

## Dispatch Output

```md
## Requirement Dispatch: <Name>

Docs Updated:
- [ ] `docs/product.md`
- [ ] `docs/architecture.md`
- [ ] `docs/api-contract.md`
- [ ] `docs/tasks.md`
- [ ] `docs/decisions.md`

Tasks:
- <Task ID>: <Title> -> <Conversation>

Dependencies:
- <Task ID> depends on <Task ID>

Copy-ready instruction for <Conversation>:

```text
Please follow prompts/<role>.md and work on <Task ID>.
Use docs/tasks.md as the source of truth.
When complete, output task delivery using docs/completion.md for product acceptance.
Do not merge to main.
```
```
