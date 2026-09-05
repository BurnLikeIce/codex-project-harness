# Project Harness Design Contract

## Purpose

Keep project facts, important decisions, progress, and verification evidence accurate enough for later work to continue. The agent chooses how to plan, implement, test, and delegate.

Project Harness remains model-independent and usable without an auxiliary skill. Generic execution methods and native task lifecycle behavior belong to the agent and runtime.

## Request Scope

Use ordinary project intent and existing project entries for discovery. No command matrix, mandatory execution tiers, or specialist roles are required.

Discussion and review-only requests stay within their scope. Explicit adoption or clearly approved project execution under Harness permits minimal binding and relevant record maintenance. Naming the Skill alone does not authorize writes.

Existing authorization persists within its intended scope. Routine follow-through should not require repeated approval. Respect project-specific constraints and explicit user limits.

Syncing rules only rereads the local installation. Binding updates, installation updates, and structural reorganization are distinct operations.

## Project Records

Keep a small project map and link to existing sources. Default missing sources remain `HARNESS.md`, `docs/tasks.md`, `docs/decisions.md`, and a managed entry in `AGENTS.md`.

Record by lasting impact rather than edit size. Update existing work first, preserve useful history, and link to canonical decisions, specifications, and evidence instead of duplicating them. Routine implementation narration does not belong in ledgers.

Agents maintain stable identifiers using the project's scheme or `TASK-0001` and `DEC-0001`. One coordinator reserves shared identifiers before concurrent dispatch; execution units do not race to allocate the same sequence.

Update records at meaningful changes and closeout. On resumption, compare relevant records with actual evidence. Correct stale progress; do not turn implemented behavior into an agreed requirement merely because it exists.

Implementation, verification, user acceptance, merge, and release are separate facts. Record each only when observed or confirmed. An action already completed must not remain the next step.

## Completion and Handoff

Use proportional reports with results, relevant evidence, remaining issues, and next actions. Read-only review reports findings. When repair is already authorized and owned by the current task, continue through repair and verification.

Provide directly usable instructions when someone else must act. Use native task capabilities for explicit creation or fork requests, subject to runtime requirements. Default to independent tasks with concise context, retain the old task, and do not establish ongoing monitoring automatically.

Update durable state before handoff and ensure the receiving workspace can access the necessary sources. Report actual setup and delivery status; pending or failed delivery is not completion. Keep a copyable fallback and preserve existing status labels as optional compatibility.

## Compatibility and Maintenance

Harness Protocol remains 2. Existing document layouts, custom source mappings, identifiers, and meaningful project rules remain valid. Installing updated instructions does not require migration.

The initializer creates only missing ledgers and preserves custom mappings. The updater changes managed blocks without rewriting surrounding content. Validation rejects unresolved required sources. Repeated setup and updates remain idempotent.

Keep references conditional. The main Skill is the shared instruction source; project-state, acceptance, coordination, Git, and adoption details are loaded only when needed. The older routing reference points to those sources.

Bundled scripts serve deterministic setup and binding maintenance. Ordinary tasks do not run a Harness maintenance suite by default.

## Verification

Keep behavioral tests for file-changing scripts, including English and Chinese setup, custom mappings, content preservation, idempotence, and invalid bindings. Do not assert exact instruction wording as proof of agent behavior.

Review instruction changes for consistency and try a small realistic scenario when useful. No separate evaluation framework or full design plan is required for routine Skill edits. Validate packaging and compare the installed Skill with the reviewed source before reporting a local update.
