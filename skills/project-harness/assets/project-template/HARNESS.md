# Project Harness

This project uses a Codex project harness workflow.

Start with the master/control conversation. The first project conversation can be the master conversation.

Default mode:

- Use one long-lived master/control conversation for ordinary product discussion, task planning, implementation, acceptance, and release decisions.
- Specialist conversations are optional. Use them only when they reduce risk, isolate work, or unblock parallel progress.
- Worktrees are optional isolation tools. Do not create them by default for every task.
- When the master/control conversation becomes too long, use a control handoff packet.

Key files:

- `docs/sop.md`: workflow rules.
- `docs/tasks.md`: task IDs and status.
- `docs/intent.md`: maps natural-language requests to harness workflows.
- `docs/migration.md`: existing project takeover and migration rules.
- `docs/refresh.md`: sync latest harness rules into existing conversations/projects.
- `docs/dispatch.md`: requirement clarification and task dispatch.
- `docs/triage.md`: issue routing and escalation rules.
- `docs/completion.md`: task delivery template for product acceptance.
- `docs/acceptance.md`: acceptance and rework template.
- `docs/single-conversation-harness.md`: default single master/control conversation mode.
- `docs/worktrees.md`: branch/worktree policy and cleanup rules.
- `docs/handovers/current-control-state.md`: current master/control handoff packet.
- `docs/product.md`: product context.
- `docs/architecture.md`: architecture context.
- `docs/api-contract.md`: API contracts.
- `docs/documentation.md`: documentation map and source-of-truth guide.
- `docs/decisions.md`: decision log.
- `prompts/`: initial prompts for each conversation role.

Use docs as the source of truth. Prefer staying in the master/control conversation unless a specialist conversation is actually useful.
