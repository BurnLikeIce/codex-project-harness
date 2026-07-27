# Decisions

Record product and technical choices whose rationale or consequences should guide future work.

## Accepted

### DEC-0001 — Optimize the default experience for vibe coding

- Status: accepted
- Date: 2026-07-24
- Context: The v2.0.2 protocol can activate without leaving an observable project binding, and its flexible task records depend too heavily on agent interpretation. The primary audience may not know professional project-management terminology or maintain task records manually.
- Decision:
  - Make the default experience local-first, agent-first, and human-auditable.
  - Treat an explicit request to apply Project Harness as authorization to inspect and persist the minimal project binding.
  - Create simple local task and decision ledgers by default for ordinary vibe coding projects.
  - Assign stable identifiers to durable tasks and decisions.
  - Require agents to inspect relevant history before creating new durable work.
  - Keep professional systems such as Jira and ADR as optional advanced mappings.
- Consequences:
  - Users make fewer operational decisions and can work through natural language.
  - Agents carry more responsibility for maintaining task state, relationships, evidence, and next actions.
  - The Skill text, templates, references, documentation, and small existing test assertions carry the more explicit contract.
  - Existing scripts remain unchanged until real usage demonstrates a mechanical gap.
  - Existing professional projects remain compatible without shaping the beginner experience.
- Linked task: `TASK-0001`

## Superseded

No superseded decisions.
