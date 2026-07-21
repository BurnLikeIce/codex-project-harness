# Intent and Work Routing

## Semantic Intent

Infer intent from the user's meaning and current project state. Examples are illustrative, not required phrases.

| Intent | Typical meaning | Harness action |
| --- | --- | --- |
| Explore | "Can this be done?" | Discuss; do not start implementation unless durable output is requested. |
| Commit | "Do it this way" | Record the smallest sufficient task and any durable decision, then execute or coordinate. |
| Problem | "This display is wrong" | Triage directly; escalate record and coordination only when impact requires it. |
| Accept | "Review these results" | Compare criteria and evidence; return status and next control action. |
| Sync | "Sync the latest project-harness" | Reload rules only; make no file or Git changes. |
| Update | "Update this project's harness" | Apply the managed, in-place compatibility update. |
| Migrate | "Move this project to the latest structure" | Propose a structural plan; wait for confirmation before changing structure. |
| Handoff | "Move control to a new conversation" | Refresh durable state and produce a concise control handoff. |

When wording is incomplete, infer from the surrounding conversation. Ask only when different interpretations would materially change scope, authority, data, architecture, release, or destructive actions.

## Durable Record Test

Record a task when any answer is yes:

1. Will future work need to know this happened?
2. Does it change user behavior, product rules, architecture, API, data, auth, security, deployment, or release behavior?
3. Does it contain a meaningful product or technical choice?
4. Does another module, owner, conversation, branch, or worktree depend on it?
5. Does it require acceptance, rollback, recovery, or a later next action?

Record a decision only when a choice and rationale should guide future work. Link the decision from the task instead of duplicating the rationale.

## Execution Topology Test

Use Direct unless evidence supports escalation.

Use Structured when the task is ambiguous, risky, cross-module, hard to verify, or likely to outlive the current execution context.

Use Coordinated when at least two units are independent enough to proceed in parallel and their ownership or integration boundary can be stated clearly. Do not parallelize tightly coupled edits merely to create more workers.
