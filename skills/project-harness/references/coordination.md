# Coordination and Handoff

## Shared Work

The agent chooses execution methods and internal workers. Harness records only the boundaries needed for safe continuation: the outcome, relevant sources, responsibility, allowed write scope, dependencies, and required evidence.

Assign one owner for each shared record or overlapping change. Before integration, reconcile results and resolve shared-contract questions. Do not impose permanent specialist roles.

When allocating project-wide identifiers concurrently, one coordinator re-reads the shared ledger and reserves the next unused identifier before dispatch. Workers use assigned references and return unnumbered proposals for new work. If reservation is unavailable, use temporary references and allocate durable IDs during integration.

## Native Tasks and Workspaces

Create a user-visible task or fork only when the user explicitly requests it. Prefer an independent task with concise context; use native context inheritance when requested.

Follow native tool requirements for creation, setup, and delivery, including any bounded completion check. Do not establish ongoing monitoring or automatically archive the originating task. The user follows the new task directly unless they request continued coordination.

A fresh conversation and a fresh Git checkout are different choices. Follow the requested workspace and native environment rules; account for concurrent writes and record the actual branch or worktree when it affects integration. Do not add branches or worktrees just to match task roles.

## Handoff Contents

Update relevant durable state before handing work over. Send a self-contained packet with only what matters:

- project and working location, including the branch or checkout when relevant;
- objective, scope, and acceptance criteria;
- sources to read first, settled decisions, and protected constraints;
- observed progress, verification evidence, blockers, and exact next action.

If the receiving task will use a different checkout, ensure required files and uncommitted state are available there, or identify what is missing before execution. Never assume a new worktree includes local uncommitted changes.

Use existing records for the packet. Create a focused handoff file only for unresolved context that does not fit them. It is not a required project file.

## Delivery and Continuation

For a whole-project handoff, make the transfer of responsibility explicit. An independent task for one outcome does not replace responsibility for the whole project.

Report the actual creation and delivery state and link the receiving task when available. Pending setup is not a completed handoff. If a task exists but delivery fails, reuse it rather than blindly creating another.

If delivery is unavailable, provide the packet or one directly usable restart instruction. Keep the originating task responsible until the receiving task has the necessary context. Existing `READY_TO_HANDOFF` and `HANDOFF_COMPLETE` labels remain usable, but plain-language results are sufficient.

A receiving task reads the mapped sources and reconciles the recorded state before resuming; it should not need to reconstruct the entire chat history.
