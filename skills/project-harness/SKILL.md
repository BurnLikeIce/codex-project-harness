---
name: project-harness
description: Maintain project facts, decisions, progress, and handoffs during ongoing software work. Use when starting or resuming a project, discussing or implementing changes, investigating problems, reviewing results, or moving work to another task; also when HARNESS.md or a Project Harness entry applies. Recognize ordinary English or Chinese intent without exact commands. Exclude unrelated questions and isolated mechanical edits with no durable project impact.
---

# Project Harness

Keep project facts, important decisions, task progress, and verification evidence accurate so later work can continue reliably. Let the active agent choose its execution methods for the task and runtime.

Communicate in the user's language; follow the project's established language for documents.

## Understand the Request

Infer intent from context without requiring fixed commands or role names. Keep discussion and read-only review within their requested scope. Once execution is requested, carry the authorized work through to completion. Existing authorization continues within its original scope; do not ask again for routine follow-through.

"Sync the latest project-harness" means reread the locally installed rules. It does not edit project files or Git state, download a release, or replace the installation. Updating project bindings or reorganizing documents follows the user's actual request.

## Read and Adopt

Read relevant project guidance and sources. Use `HARNESS.md`, when present, to locate the documents needed for this task rather than loading all history.

When the user asks to adopt Harness or clearly starts project execution under it, inspect the current structure and reuse equivalent sources. Where missing, use `HARNESS.md` for the project map, `docs/tasks.md` for tasks, `docs/decisions.md` for decisions, and a short entry in `AGENTS.md`.

Preserve existing content and layout. Do not repeat Git initialization or reorganize a project merely to fit a template. Naming the Skill alone does not authorize persistent setup.

## Record Important Changes

Record what future work needs to know: product behavior, meaningful technical choices, shared contracts, unfinished work, blockers, and acceptance outcomes. Impact determines the need to record, not the size of the edit.

Update existing tasks and relevant documents first. Link to specifications, contracts, and evidence instead of duplicating them. Purely mechanical changes may remain traceable through Git.

Use existing identifiers, or `TASK-0001` and `DEC-0001` when no scheme exists. Agents maintain identifiers and state; retain completed, cancelled, and superseded history.

Update relevant records when requirements settle, scope or decisions change, work blocks, and work closes. Record necessary agreements before independent execution or handoff. Do not keep a tool-by-tool diary.

## Keep State Accurate

On resumption and completion, reconcile relevant records with observed results. Correct stale progress and next actions so completed work is not repeated.

Distinguish agreed requirements from implemented behavior. Surface conflicts; code alone is not authority to rewrite a requirement.

Record what was verified, the observed result, and what remains unknown. Implementation, verification, user acceptance, merge, and release are separate facts; report each only when supported.

## Complete and Review

Describe the result, necessary evidence, unresolved issues, and next action in proportion to the task. No fixed response form is required.

When acceptance fails, identify the failed criterion, actual behavior, and expected result. If repair is already authorized and belongs to the current task, fix and verify it. When another task or the user must act, provide a directly usable instruction.

A review-only request calls for findings and recommendations. After acceptance, complete authorized follow-through and update the record; ask only for decisions that are still needed.

## Coordinate and Hand Off

Keep ordinary work in the current task. Planning, testing, and internal subagents are chosen as needed; no execution tiers or fixed product, frontend, and backend roles are required.

Use native capabilities when the user explicitly requests a new task or fork. New tasks are independent without full chat history by default; inherit context when requested. Do not automatically archive the old task or establish ongoing monitoring.

Before handoff, update relevant state and supply the objective, project location, required sources, key constraints, unfinished work, and next action. Report actual creation and delivery results. If the capability is unavailable, provide a directly usable restart instruction.

## Read References as Needed

- [project-state.md](references/project-state.md): task, decision, and document maintenance.
- [acceptance.md](references/acceptance.md): acceptance and rework.
- [coordination.md](references/coordination.md): handoffs, concurrent writes, and identifier allocation.
- [git-release.md](references/git-release.md): Git, integration, and project release boundaries.
- [update-existing-project.md](references/update-existing-project.md): adoption, binding updates, and structural changes.

Use the bundled inspection, initialization, update, and validation scripts when adoption or binding maintenance needs them. Ordinary project work does not require the full Harness check suite.
