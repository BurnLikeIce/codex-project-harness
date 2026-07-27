# Applying and Refreshing Project Governance

## Inspect and Reuse

Inspect the repository, Git state, `AGENTS.md`, `HARNESS.md`, README files, docs, plans, task trackers, decision logs, contracts, and release guidance. Build a source map and preserve existing canonical files.

Apply one state-aware flow:

1. reuse equivalent project sources when they exist;
2. create only the minimal governance files that are missing;
3. preserve the current structure and custom content;
4. establish or confirm the control context.

Do not ask the user to classify the project before inspection. Do not install a template over equivalent project files merely because their names differ.

## Persistently Adopt a Project

Selecting or naming the Skill only activates its rules. An explicit request to use, adopt, set up, or apply Project Harness to manage the project is permission to write the minimal project binding.

Inspect first, then run the state-aware initializer for adoption. It must reuse each equivalent task or decision source independently, create only the missing ledger for an unmapped category, refresh the managed project map, and run validation. A project with `TASKS.md` but no decision ledger, for example, keeps `TASKS.md` and receives only a missing decision ledger.

The updater is a refresh-only operation. It maps sources that already exist and may leave an unresolved category visible, but validation must reject a persistent binding whose required task or decision source is unmapped or missing.

Report `ADOPTED` when a binding was created or repaired, `ALREADY_ADOPTED` when a valid binding already existed and nothing changed, or `BLOCKED` with the exact required action when safe adoption or validation cannot complete.

## Sync Conversation Rules

"Sync the latest Project Harness" is read-only. Reload the installed skill and continue using the project's existing facts. Do not run initialization or update scripts. Confirm that no project files or Git state changed.

## Refresh Managed Project Bindings

Run the update script only when the user intends to refresh project files, not merely the conversation.

The updater may create or replace clearly delimited managed blocks in `HARNESS.md` and `AGENTS.md`. It must preserve all text outside those blocks, report the detected source map, and be idempotent.

Use the project's language when known:

```powershell
scripts/update-project.ps1 -ProjectPath <path> -Language zh-CN
```

```bash
scripts/update-project.sh --project-path <path> --language zh-CN
```

Review the diff after updating. Do not automatically commit or push it.

## Explicit Structural Change

Moving or consolidating project files is separate from applying governance. Before any structural change:

1. inventory existing files and custom content;
2. identify duplicate or conflicting sources;
3. propose keep, link, merge, archive, or delete actions;
4. identify Git and collaboration impact;
5. wait for confirmation.

Never make structural reorganization a prerequisite for using the currently installed Harness protocol.
