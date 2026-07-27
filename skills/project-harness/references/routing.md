# Intent and Work Routing

## Activation Order

Use the first matching layer:

1. **Explicit adoption:** the user selects Project Harness or asks to use it to manage the project.
2. **Project-level continuity:** `HARNESS.md` or a managed Project Harness entry is present and the request may affect durable project work.
3. **Semantic activation:** ordinary language clearly indicates starting, resuming, discussing, implementing, debugging, accepting, summarizing, coordinating, or handing off project work.
4. **No activation:** unrelated Q&A, translation, casual conversation, or an isolated mechanical edit with no durable project impact.

Do not ask the user whether a project is new, existing, governed, or controlled. Inspect and infer those states internally. Do not require words such as Harness, control, coordinator, task ID, product conversation, frontend conversation, or backend conversation.

## Semantic Routing

Infer intent from the user's meaning and current project state. Examples are illustrative, not required phrases.

| Intent | Typical meaning | Harness action |
| --- | --- | --- |
| Adopt | "Use Project Harness to manage this project" | Inspect, persist the minimal safe binding, validate it, and report `ADOPTED`, `ALREADY_ADOPTED`, or `BLOCKED`. |
| Start | "I want to build an app" | Inspect the workspace. When the intent is to begin execution, establish the minimal missing project map and proceed. |
| Resume | "Continue this project" | Inspect and read current state, reuse existing sources, and continue without repeated initialization. |
| Explore | "Can this be done?" | Discuss; do not start implementation unless durable output is requested. |
| Commit | "Do it this way" | Record the smallest sufficient task and any durable decision, then execute or coordinate. |
| Problem | "This display is wrong" | Triage directly; escalate record and coordination only when impact requires it. |
| Accept | "Review these results" | Compare criteria and evidence; return status and next control action. |
| Status | "Where are we now?" | Read durable state and summarize current progress, risks, and next action. |
| Sync | "Sync the latest project-harness" | Reload rules only; make no file or Git changes. |
| Update | "Update this project's harness" | Apply the managed, in-place compatibility update. |
| Migrate | "Move this project to the latest structure" | Propose a structural plan; wait for confirmation before changing structure. |
| Handoff | "Move control to a new conversation" | Refresh durable state and produce a concise control handoff. |

When wording is incomplete, infer from the surrounding conversation. Ask only when different interpretations would materially change scope, authority, data, architecture, release, or destructive actions.

## Persistence Boundary

Activation and persistence are separate decisions.

| Project state and intent | Allowed behavior |
| --- | --- |
| No Harness marker; exploration only | Discuss and inspect read-only context as needed. Do not initialize governance files, implementation records, or claim adoption. |
| No Harness marker; explicit adoption or approved execution | Inspect first, reuse equivalent sources, persist only the minimal missing governance files, and validate the result. |
| Harness marker present; durable project work | Read `HARNESS.md`, apply current rules automatically, and update only records justified by durable impact. |
| Explicit conversation sync | Reload installed rules and leave files and Git state unchanged. |
| Unrelated or purely mechanical request | Continue normally without introducing Harness records or terminology. |

Use the current conversation as the internal coordinator by default. Explain coordination roles only when multiple owners, execution units, or a handoff make that distinction useful.

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
