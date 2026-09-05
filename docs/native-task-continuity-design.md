# Native Codex Task Continuity

- Status: implemented
- Date: 2026-08-20
- Task: `TASK-0002`
- Decision: `DEC-0002`

## Decision

Project Harness remains a project-governance Skill, not a second task manager. Codex owns user-visible task creation, forking, display, and retention. Harness supplies durable project state and a compact continuation packet.

The default is simple:

- ordinary work stays in the current task;
- a user-visible task is created only from explicit semantic user intent;
- a new task is clean and independent by default;
- a native fork is used only when the user explicitly requests context inheritance;
- the originating task remains available and does not monitor the new task;
- fixed product, frontend, backend, and bug-fix task roles are not required.

## Routing

| User intent | Behavior |
| --- | --- |
| Continue or implement | Work in the current task. |
| Create or separate work | Create one native task and send a compact project packet. |
| Fork or try an alternative with current context | Use native context inheritance. |
| Hand off the whole project | Refresh durable state, create a clean task, deliver the packet, and return `HANDOFF_COMPLETE`. |

Meaning matters more than exact wording. Complexity alone does not authorize a new user-visible task.

## Project Packet

Include only what the receiving task needs: project path, objective, sources to read first, settled constraints, acceptance criteria, prohibited operations, and the recorded next action. Do not copy the full conversation.

## Boundaries

- Task creation follows native workspace requirements; Harness does not create branches or worktrees to match roles.
- Do not archive the originating task automatically.
- Do not monitor the new task by default.
- Do not change project templates, scripts, or Harness Protocol 2 for this adaptation.
- When native creation or message delivery is unavailable, return `READY_TO_HANDOFF` with one directly usable restart instruction.

Existing Harness projects need no migration; updating the installed Skill is sufficient. The current [design contract](harness-v2-design.md) allows plain-language delivery results; the status labels above remain available for compatibility.
