# Harness Refresh

Use this document when the user asks any conversation to sync, refresh, update, or continue with the latest project-harness rules.

Typical short prompt:

```text
Sync the latest project-harness skill.
```

Similar natural-language requests also count.

## Two Levels

### Conversation Rule Refresh

Any conversation can do this.

When asked to sync the latest project-harness skill:

- Re-orient to the current conversation role: master, product, frontend, backend, bugfix, experiment, or other.
- Read or follow the matching role prompt in `prompts/` when present.
- Use the latest workflow docs relevant to that role:
  - `docs/intent.md`
  - `docs/dispatch.md`
  - `docs/triage.md`
  - `docs/completion.md`
  - `docs/acceptance.md`
  - `docs/migration.md`
- Continue future work using the latest rules.

### Project Harness File Refresh

Master/control conversation owns this.

When asked to update the project's harness docs:

- Inspect current `docs/`, `prompts/`, `HARNESS.md`, README, and `.github`.
- Compare against the latest project-harness template.
- Do not overwrite existing docs.
- Propose an update plan if changes are more than trivial.
- Add missing templates, or create index/link files when existing docs already cover the content.

## Role-Specific Short Prompts

```text
Sync the latest project-harness skill.
```

```text
Sync the latest project-harness master rules.
```

```text
Sync the latest project-harness product rules.
```

```text
Sync the latest project-harness frontend rules.
```

```text
Sync the latest project-harness backend rules.
```

```text
Sync the latest project-harness bugfix rules.
```

## Output

After refresh, briefly report:

- Role understood:
- Rules/docs now in effect:
- Missing project docs, if any:
- Next recommended action:
