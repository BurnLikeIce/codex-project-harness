# Codex Project Harness

Project Harness is a bilingual, adaptive project-governance skill for Codex. It keeps durable project facts, decisions, constraints, task state, acceptance evidence, and coordination boundaries usable across long-running software work.

It gives Codex a small project map and stable sources of truth without prescribing how every implementation task must be planned or executed.

[中文说明](README.zh-CN.md)

## What It Manages

- Project knowledge maps and sources of truth
- Durable task and decision records
- Product, architecture, contract, authority, and release boundaries
- Acceptance evidence and required next actions
- Control handoff between long-running conversations
- Coordination boundaries for parallel tasks, branches, or worktrees
- Backward-compatible updates for projects created with Project Harness V1

Project Harness does not require a fixed development methodology, number of conversations, branch strategy, worktree strategy, or auxiliary skill.

## Adaptive Behavior

Project Harness makes two independent decisions:

1. **Durable impact:** whether work must be recorded because it changes product behavior, contains a meaningful decision, affects a shared contract, or must survive acceptance, ownership, or conversation changes.
2. **Execution topology:** whether work is best handled directly, as structured multi-stage work, or as coordinated parallel units.

A tiny product or technical decision can require a durable record. A large mechanical edit may need structured execution without creating a permanent decision.

## Minimal New-Project Footprint

New projects receive only:

```text
AGENTS.md
HARNESS.md
docs/
  tasks.md
  decisions.md
```

Product, architecture, API, security, deployment, testing, release, and handoff documents are created only when the project needs them. Equivalent existing files are reused instead of duplicated.

## Install

### Download Without a Terminal

1. Download this repository as a ZIP from GitHub.
2. Unzip it.
3. Copy `skills/project-harness` into your Codex skills directory.
4. Restart Codex.

The final path must be:

```text
~/.codex/skills/project-harness/SKILL.md
```

On macOS, open Finder, press `Command + Shift + G`, and enter `~/.codex/skills`.

On Windows, the usual destination is `%USERPROFILE%\.codex\skills\project-harness`.

### Install With Git

Clone the repository, then copy or link `skills/project-harness` into `~/.codex/skills/project-harness`. Restart Codex after installation or replacement.

## Quick Start

Project Harness recognizes natural-language meaning; the examples below are not exact commands.

### New Project

```text
Use project-harness to start this project. This conversation is the control conversation.
```

### Existing Project

```text
Use project-harness in this existing project. Preserve the current files and make this the control conversation.
```

### Sync a Conversation

```text
Sync the latest project-harness.
```

This reloads the current skill rules and must not edit project files.

### Update an Existing Harness Project

```text
Update this project's project-harness.
```

This performs an in-place compatibility update. It preserves existing files and custom content and updates only clearly marked Harness sections in `HARNESS.md` and `AGENTS.md`.

### Optional Structural Migration

```text
Migrate this project to the latest Harness structure.
```

Migration is optional. Codex must inspect and propose a plan before moving, merging, archiving, or deleting existing files.

## Update Is Not Migration

Projects created with V1 can use the latest Project Harness without reorganizing their documents. V2 understands the V1 layout and maps existing task, decision, product, architecture, API, acceptance, handoff, and workflow files.

The in-place updater is idempotent and does not modify content outside managed blocks. Repeated updates with the same project state produce no additional diff.

## Bundled Scripts

Windows PowerShell:

```powershell
skills/project-harness/scripts/inspect-project.ps1 -ProjectPath <path>
skills/project-harness/scripts/init-project.ps1 -ProjectPath <path> -Language en
skills/project-harness/scripts/update-project.ps1 -ProjectPath <path> -Language en
skills/project-harness/scripts/validate-project.ps1 -ProjectPath <path>
```

macOS/Linux:

```bash
skills/project-harness/scripts/inspect-project.sh <path>
skills/project-harness/scripts/init-project.sh --project-path <path> --language en
skills/project-harness/scripts/update-project.sh --project-path <path> --language en
skills/project-harness/scripts/validate-project.sh <path>
```

Use `zh-CN` for Chinese project templates and managed sections.

## Development and Validation

```powershell
tests/run-tests.ps1
```

```bash
sh tests/run-tests.sh
```

The test suite covers minimal English and Chinese initialization, V1 custom-content preservation, source mapping, in-place update idempotence, and managed-structure validation.

## Project Status

Harness 2.0 is under active development. The V1 baseline remains available through the `v1.0.0` Git tag.

This is a community project and is not an official OpenAI project.

## License

[MIT](LICENSE)
