# Changelog

## Unreleased

- Focused Skill instructions on project facts, meaningful decisions, progress, and verification evidence.
- Removed mandatory execution tiers and fixed replies; preserved read-only review and sync while allowing authorized follow-through.
- Clarified state reconciliation and workspace-aware handoffs, with existing project layouts and Protocol 2 unchanged.
- Replaced exact instruction wording checks with script-focused validation and localized template-copy checks.
- Separated Skill activation from authorization to persist project files.
- Made adoption preserve valid custom mappings, reuse partial existing task and decision sources, and create only missing ledgers.
- Made validation reject missing or unresolved required source mappings.
- Assigned global task and decision identifier allocation to one active project coordinator.
- Restored an explicit, lightweight conversation-handoff contract with `READY_TO_HANDOFF`.
- Added lightweight native Codex task creation, explicit-fork routing, and delivered handoff support without changing project templates or scripts.

## 2.0.2 - 2026-07-21

- Added three-layer activation through ordinary project intent, project-level continuity, and explicit fallback.
- Kept exploratory discussion read-only until the user clearly starts, resumes, or approves execution.
- Made coordinator and control-context terminology internal by default.
- Added persistent semantic-activation guidance to generated English and Chinese `AGENTS.md` entries.

## 2.0.1 - 2026-07-21

- Unified project setup behind one state-aware natural-language entry point.
- Made project classification and compatibility handling internal Harness behavior.
- Simplified the public README files around installation, governance, and everyday use.
- Preserved project layouts and mapped sources of truth by default.

## 2.0.0 - 2026-07-21

- Reframed Project Harness as an adaptive project-governance layer.
- Reduced the default project footprint to `AGENTS.md`, `HARNESS.md`, `docs/tasks.md`, and `docs/decisions.md`.
- Added semantic intent routing for sync, in-place update, and optional migration.
- Added backward-compatible, idempotent V1 project updates.
- Added focused references for project state, routing, coordination, acceptance, Git, and existing-project updates.
- Added Windows PowerShell and POSIX shell behavior tests.
- Removed fixed role prompts and full-project SOP installation from the default workflow.

## 1.0.0 - Baseline

- Preserved the original single-control and optional multi-conversation Project Harness workflow in the `v1.0.0` Git tag.
