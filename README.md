# Codex Project Harness

Project Harness is a bilingual, adaptive project-governance skill for Codex. It keeps project facts, decisions, constraints, task state, acceptance evidence, and coordination boundaries usable across long-running software work.

It gives Codex a small project map and stable sources of truth without prescribing how every implementation task must be planned or executed.

[中文说明](README.zh-CN.md)

## What It Manages

- Project knowledge maps and sources of truth
- Durable task and decision records
- Product, architecture, contract, authority, and release boundaries
- Acceptance evidence and required next actions
- Control handoff between long-running conversations
- Coordination boundaries for parallel tasks, branches, or worktrees

Project Harness does not require a fixed development methodology, number of conversations, branch strategy, worktree strategy, or auxiliary skill.

## How It Adapts

Project Harness makes two independent decisions:

1. **Durable impact:** whether work must be recorded because it changes product behavior, contains a meaningful decision, affects a shared contract, or must survive acceptance, ownership, or conversation changes.
2. **Execution topology:** whether work is best handled directly, as structured multi-stage work, or as coordinated parallel units.

A tiny product or technical decision can require a durable record. A large mechanical edit may need structured execution without creating a permanent decision.

## Project Footprint

The default governance footprint is intentionally small:

```text
AGENTS.md
HARNESS.md
docs/
  tasks.md
  decisions.md
```

Product, architecture, API, security, deployment, testing, release, and handoff documents are created only when the project needs them. Project Harness inspects the repository and reuses equivalent files instead of creating duplicate sources of truth.

## Install

### Download Without a Terminal

1. Download the Project Harness Skill ZIP from the [latest release](https://github.com/BurnLikeIce/codex-project-harness/releases/latest).
2. Unzip it.
3. Copy the `project-harness` folder into your Codex skills directory.
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

In the project conversation, say:

```text
Use project-harness to set up project governance here and make this conversation the control context.
```

Project Harness recognizes natural-language meaning, so equivalent phrasing works. It inspects the project first, preserves existing files, establishes the project map, and creates only the governance files that are actually missing.

After that, work normally. Examples include:

```text
Let's discuss whether this feature should be built.
```

```text
Proceed with what we agreed.
```

```text
Accept these implementation results and tell me the next action.
```

To make a long-running conversation reload the currently installed rules, say:

```text
Sync the latest project-harness.
```

Syncing conversation rules does not edit project files.

## Bundled Scripts

Windows PowerShell:

```powershell
skills/project-harness/scripts/inspect-project.ps1 -ProjectPath <path>
skills/project-harness/scripts/init-project.ps1 -ProjectPath <path> -Language en
skills/project-harness/scripts/validate-project.ps1 -ProjectPath <path>
```

macOS/Linux:

```bash
skills/project-harness/scripts/inspect-project.sh <path>
skills/project-harness/scripts/init-project.sh --project-path <path> --language en
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

The test suite covers English and Chinese initialization, preservation of project content, source mapping, idempotent managed updates, and structure validation.

## Project Status

This is a community project and is not an official OpenAI project.

## License

[MIT](LICENSE)
