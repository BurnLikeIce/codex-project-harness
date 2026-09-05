# Adoption and Binding Maintenance

## Inspect and Reuse

For adoption, inspect project guidance, the existing map, and likely task and decision sources. Reuse each category independently, preserve custom paths, and create only missing records. Avoid a whole-project documentation audit unless it is needed.

Selecting or naming the Skill alone does not authorize setup. A request to manage the project, or clearly approved project execution under Harness, permits the minimal binding. Keep exploration and review-only requests read-only.

## Script Entry Points

Use the matching PowerShell or POSIX entry points under `scripts/`:

| Operation | PowerShell | POSIX |
| --- | --- | --- |
| Inspect | `inspect-project.ps1 -ProjectPath <path>` | `inspect-project.sh <path>` |
| Adopt | `init-project.ps1 -ProjectPath <path> -Language en` | `init-project.sh --project-path <path> --language en` |
| Refresh bindings | `update-project.ps1 -ProjectPath <path> -Language en` | `update-project.sh --project-path <path> --language en` |
| Validate | `validate-project.ps1 -ProjectPath <path>` | `validate-project.sh <path>` |

Use `zh-CN` for Chinese templates and managed sections. These scripts support setup and maintenance, not an every-task ritual.

The initializer preserves valid custom mappings, reuses partial task or decision sources, creates missing ledgers, and validates the binding. The updater refreshes managed blocks and maps existing sources; it does not create missing ledgers. Validation must reject a missing or unmapped required source.

Review the resulting diff and report what was established or remains unresolved. Existing `ADOPTED`, `ALREADY_ADOPTED`, and `BLOCKED` labels remain usable without requiring a fixed response form.

## Sync and Updates

"Sync the latest project-harness" only reloads locally installed rules. Do not run scripts, edit project files, change Git state, download updates, or reinstall the Skill.

When the user requests binding updates, refresh only managed sections and preserve other content. Repeating the same update should produce no further diff.

Updating the installed Skill does not require migrating projects or regenerating their documents. Existing layouts, mappings, and identifiers remain valid. Preserve project-specific requirements when older generic workflow text conflicts with current Skill guidance.

## Structural Changes

Reorganization is separate from adoption or a binding refresh. Establish affected paths and intended changes before moving or consolidating documents. Proceed within already approved scope; clarify unresolved changes rather than adding a second approval after a concrete plan is authorized.
