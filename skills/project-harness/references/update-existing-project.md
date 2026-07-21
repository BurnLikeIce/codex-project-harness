# Existing-Project Adoption, Update, and Migration

## Adopt Without Restructuring

Inspect the repository, Git state, `AGENTS.md`, `HARNESS.md`, README files, docs, plans, task trackers, decision logs, contracts, and release guidance. Build a source map and preserve existing canonical files.

Do not install the minimal new-project template over an existing project merely because its file names differ.

## Sync Conversation Rules

"Sync the latest Project Harness" is read-only. Reload the installed skill and continue using the project's existing facts. Do not run initialization or update scripts. Confirm that no project files or Git state changed.

## Update Harness In Place

Run the update script only when the user intends to update the project, not merely the conversation.

The updater may create or replace clearly delimited managed blocks in `HARNESS.md` and `AGENTS.md`. It must preserve all text outside those blocks, report the detected source map, and be idempotent.

Use the project's language when known:

```powershell
scripts/update-project.ps1 -ProjectPath <path> -Language zh-CN
```

```bash
scripts/update-project.sh --project-path <path> --language zh-CN
```

Review the diff after updating. Do not automatically commit or push it.

## Optional Structural Migration

Migration is separate from update. Before migration:

1. inventory existing files and custom content;
2. identify duplicate or conflicting sources;
3. propose keep, link, merge, archive, or delete actions;
4. identify Git and collaboration impact;
5. wait for confirmation.

Never make migration a prerequisite for using the latest Harness protocol.
