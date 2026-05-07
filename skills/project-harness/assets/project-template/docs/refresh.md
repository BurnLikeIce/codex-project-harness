# Harness Refresh

Use this document when the user asks any conversation to sync, refresh, update, or continue with the latest project-harness rules.

Typical short prompt:

```text
Sync the latest project-harness skill.
```

Similar natural-language requests also count.

## Hard Boundary

There are two different refresh actions:

- Conversation rule refresh: any conversation may do this.
- Project harness file refresh: only the master/control conversation may do this.

Non-master conversations must not edit harness files such as `docs/`, `prompts/`, `HARNESS.md`, README, or `.github` just because the user asked to sync the latest project-harness skill.

If a non-master conversation notices missing or outdated harness docs, it should output a copy-ready instruction for the master conversation instead of editing files.

## Conversation Rule Refresh

Any conversation can refresh its own behavior.

When asked to sync the latest project-harness skill:

- Identify the current conversation role: master, product, frontend, backend, bugfix, experiment, or other.
- Read or follow the matching role prompt in `prompts/` when present.
- Use the workflow docs relevant to that role:
  - `docs/intent.md`
  - `docs/dispatch.md`
  - `docs/triage.md`
  - `docs/completion.md`
  - `docs/acceptance.md`
  - `docs/migration.md`
- Continue future work using the latest rules.
- Do not edit harness files unless this is the master/control conversation and the user asked to update project harness docs.

## Project Harness File Refresh

Only the master/control conversation owns this.

When the master conversation is asked to update the project's harness docs:

- Inspect current `docs/`, `prompts/`, `HARNESS.md`, README, and `.github`.
- Compare against the latest project-harness template.
- Do not overwrite existing docs.
- Propose an update plan if changes are more than trivial.
- Add missing templates, or create index/link files when existing docs already cover the content.

## Non-Master Escalation

If a product/frontend/backend/bugfix/experiment conversation finds that project harness files need updating, output:

```text
Please send this to the master/control conversation:

Sync the latest project-harness skill and check whether this project's harness docs need updating.
Do not overwrite existing docs. If updates are needed, propose a plan first.
```

## Output

After refresh, briefly report:

- Role understood:
- Rules/docs now in effect:
- Whether project-file refresh is needed:
- Next recommended action:
