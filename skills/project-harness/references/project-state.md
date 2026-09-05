# Project State

## Sources and Scope

Use `HARNESS.md` as an index to canonical project documents. Read only the sources relevant to the current work; search related history before creating a duplicate task or reopening a settled decision.

Keep requirements and observations distinct. A failing implementation does not invalidate a requirement, and an old progress note does not override newer verification or merge evidence. Correct stale status from evidence; surface substantive requirement conflicts for resolution.

## Tasks

Use the project's existing record format. A small task may need only its identifier, outcome, status, and next action; add constraints, acceptance criteria, dependencies, and evidence when they matter for continuation.

Update a matching task first. Link regressions or extensions to earlier work. Record small product or technical changes when they affect future behavior; do not create a separate record for every edit.

Use stable `TASK-0001` identifiers if no scheme exists. Keep completed, cancelled, and superseded history. For concurrent allocation, read [coordination.md](coordination.md).

## Decisions

Record choices whose rationale should guide later work: what was decided, why, affected requirements or contracts, and status. Link supporting sources and related tasks. Use the project's scheme, or `DEC-0001`.

Routine implementation choices do not need permanent decision records. A meaningful choice within a small task does. If the canonical specification already records the choice and rationale, link to it rather than copying the same text into several documents.

Retain replaced decisions with a link to the replacement.

## Update Timing

Update relevant records when requirements settle, scope or decisions change, a blocker appears, or work closes. Before independent execution, record the agreements needed by the recipient.

On resumption, reconcile status with available evidence. On completion, update the task after the actual result, including acceptance, integration, or release when those occurred. Avoid leaving a completed action as the next step.

Implemented, verified, accepted, merged, and released describe different events. Reference the relevant checks, commit, PR, or deployment when useful, and name any unverified state. An old test result does not establish that later changes pass.

A read-only request may reveal stale records; report the discrepancy without editing them until maintenance or execution is authorized.

## Additional Documents

Reuse PRDs, API contracts, architecture notes, and other established sources. Create a focused document only when durable information is too substantial for the current record. Link it from the project map where useful.

Do not add empty placeholders or copy generic SOP text into projects. Keep unfinished work easy to find without loading the entire completed history.
