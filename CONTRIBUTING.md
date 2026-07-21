# Contributing

Thank you for helping improve Project Harness.

## Design Boundary

Contributions must preserve the core boundary: Project Harness manages durable project state, constraints, acceptance, and coordination. It does not prescribe a specific implementation methodology, runtime, auxiliary skill, number of conversations, branch strategy, or worktree strategy.

Backward-compatible project update is the default. Structural migration must remain optional and explicit.

## Before Opening a Pull Request

1. Keep `SKILL.md` concise and move conditional detail into focused references.
2. Do not copy generic workflow documentation into generated projects.
3. Preserve user and project content outside clearly marked managed blocks.
4. Add or update tests for behavior changes.
5. Run both available test suites when your environment supports them:

```powershell
tests/run-tests.ps1
```

```bash
sh tests/run-tests.sh
```

6. Run the Codex skill validator with UTF-8 enabled on Windows.

Keep pull requests focused and explain compatibility impact, verification, and any remaining risk.
