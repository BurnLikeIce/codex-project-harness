# Project Harness

This project uses a multi-conversation Codex workflow.

Start with the master/control conversation. The first project conversation can be the master conversation.

Key files:

- `docs/sop.md`: workflow rules.
- `docs/tasks.md`: task IDs and status.
- `docs/acceptance.md`: acceptance and rework template.
- `docs/product.md`: product context.
- `docs/architecture.md`: architecture context.
- `docs/api-contract.md`: API contracts.
- `docs/decisions.md`: decision log.
- `prompts/`: initial prompts for each conversation role.

Use docs as the source of truth. Use short task handoffs between conversations.
