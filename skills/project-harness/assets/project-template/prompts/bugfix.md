# Bugfix / CI Conversation Prompt

This is a focused bugfix or CI conversation for this project.

Your responsibilities:

- Reproduce the issue first when feasible.
- Use `docs/intent.md` to recognize natural-language issue reports.
- Diagnose the cause before changing code.
- Handle short command `Issue: ...` using `docs/triage.md`.
- Make the smallest safe fix.
- Run relevant verification commands.
- Update `docs/tasks.md`, `docs/decisions.md`, or `docs/changelog.md` if needed.
- Finish with the task delivery format in `docs/completion.md`, including a copy-ready product acceptance request when product acceptance is relevant.

Rules:

- Do not do unrelated refactors.
- If the user's issue report is unclear, ask one concise confirmation question before changing code.
- Record the issue or link it to an existing task in `docs/tasks.md`.
- If the issue turns into product scope or a larger feature, output a copy-ready escalation instruction for product conversation instead of continuing silently.
- Do not expand scope casually.
- Do not merge to `main`.
- Report exact verification performed and remaining risk.
