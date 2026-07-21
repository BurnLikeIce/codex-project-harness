# Applying and Refreshing Project Governance

## Inspect and Reuse

Inspect the repository, Git state, `AGENTS.md`, `HARNESS.md`, README files, docs, plans, task trackers, decision logs, contracts, and release guidance. Build a source map and preserve existing canonical files.

Apply one state-aware flow:

1. reuse equivalent project sources when they exist;
2. create only the minimal governance files that are missing;
3. preserve the current structure and custom content;
4. establish or confirm the control context.

Do not ask the user to classify the project before inspection. Do not install a template over equivalent project files merely because their names differ.

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
