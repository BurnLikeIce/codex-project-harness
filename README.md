# Codex Project Harness

Project Harness helps Codex keep project facts, decisions, progress, and verification evidence accurate across long-running work and task changes. It works in English and Chinese.

The agent maintains the records and chooses how to implement the work. Users can discuss requirements, report problems, and continue a project in ordinary language.

[中文说明](README.zh-CN.md)

## What It Keeps

- A small project map linking to existing requirements and technical documents.
- Important decisions, unfinished work, blockers, and the next action.
- Evidence separating implementation, verification, acceptance, merge, and release.
- Enough context to continue in another task.

Small changes with lasting product or technical impact are recorded. Existing tasks and documents are updated first; the same facts are not copied into several ledgers. On resumption and completion, the agent reconciles recorded progress with observed results.

Execution methods, plans, tests, and internal workers are chosen as needed. No fixed execution tiers, specialist roles, or auxiliary skills are required.

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

## Everyday Use

To explicitly adopt Harness, ask:

```text
Use project-harness to manage this project.
```

The agent reuses existing documents and creates only missing records and a project entry. It maintains task and decision identifiers, progress, and history for you.

There is no required phrase. Ordinary project requests can activate the Skill, and a project entry helps subsequent tasks discover it. Discussion and review-only requests stay within that scope; once execution is requested, the agent carries out authorized work and updates the relevant records.

| Request | Expected behavior |
| --- | --- |
| "Can this feature be built?" | Discuss the options before implementation is requested. |
| "Go ahead with this." | Implement the agreed change and record meaningful outcomes. |
| "This page is wrong. Fix it." | Investigate and repair within scope; retain any important decision. |
| "Review the result." | Explain findings, evidence, and next steps; respect review-only scope. |
| "Sync the latest project-harness." | Reread locally installed rules without editing files or downloading an update. |
| "Continue this project in a new task." | Refresh state and pass concise context through native capabilities, or provide a restart instruction. |

New tasks are independent by default; forks inherit context when requested. The old task remains available, with no automatic archiving or ongoing monitoring. Workspace selection follows the user's request and native tool rules; Harness does not create a worktree for every role.

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

Use `zh-CN` for Chinese project templates and managed sections. The agent uses these scripts for setup or binding maintenance, not on every task.

## Development and Validation

```powershell
tests/run-tests.ps1
```

```bash
sh tests/run-tests.sh
```

These are maintainer tests for the file-changing scripts: English and Chinese initialization, content preservation, source mapping, idempotent updates, and structure validation. Normal Skill use does not run this suite. Instruction changes need a consistency review and a small practical check where useful, not exact-phrase assertions.

## Project Status

This is a community project and is not an official OpenAI project.

## License

[MIT](LICENSE)
