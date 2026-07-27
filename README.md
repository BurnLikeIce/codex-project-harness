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

## Start Naturally

Project Harness has no required activation phrase. After installation, ordinary project language can activate it, for example:

```text
I want to build a personal finance app.
```

```text
Continue this project and check the current progress first.
```

```text
Can this feature be built?
```

```text
This page is wrong. Please investigate it.
```

Project Harness infers whether the user is exploring, starting, resuming, implementing, reporting a problem, accepting results, or handing off work. Exploratory discussion remains read-only. Once execution is clearly requested, it inspects the project, preserves existing files, and creates only missing governance files. Projects with a Harness entry continue using the installed rules automatically.

Users do not need to understand control-context or specialist-conversation terminology. Selecting or naming Project Harness activates its rules, but does not by itself authorize project-file changes. To explicitly adopt and persist Project Harness, ask it to manage the project:

```text
Use project-harness to manage this project.
```

Explicit adoption allows the agent to inspect the project and write the minimal binding instead of enabling the Skill only for the current conversation. The agent preserves existing `AGENTS.md` content and project documents, reuses task and decision sources independently, creates only missing ledgers, validates the result, and reports `ADOPTED`, `ALREADY_ADOPTED`, or `BLOCKED`.

After adoption, task and decision records primarily serve future agents. The active project coordinator assigns and reserves stable `TASK-0001` and `DEC-0001` identifiers, retains history, updates status, and checks related work for continuation, reuse, or conflicts before creating a new task. Parallel execution units use assigned references instead of allocating competing identifiers. Users do not maintain these records manually.

To reload updated rules in a long-running conversation, say:

```text
Sync the latest project-harness.
```

Syncing conversation rules does not edit project files.

To continue the project in another conversation, say naturally:

```text
Hand this project to another conversation.
```

The agent refreshes tasks, decisions, evidence, and the project map, creates a focused handoff file only when unresolved context needs one, and returns `READY_TO_HANDOFF` with a directly usable restart instruction.

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
