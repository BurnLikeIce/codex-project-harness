# Project Harness

<!-- project-harness:managed:start -->
## Harness Protocol

- Protocol: 2
- Tasks: `docs/tasks.md`
- Decisions: `docs/decisions.md`
- Working rule: preserve project-specific facts and use the latest installed Project Harness protocol.
<!-- project-harness:managed:end -->

## Project Map

- Current design contract: `docs/harness-v2-design.md`
- Public overview: `README.md` and `README.zh-CN.md`
- Contribution and pull-request rules: `CONTRIBUTING.md`
- Automated tests: `tests/run-tests.ps1` and `tests/run-tests.sh`

## Authority Boundaries

- The repository owner reviews and decides whether to merge pull requests.
- Do not push branches, create or merge pull requests, tag versions, or publish releases without explicit authorization.
- Develop v2.1 on `feat/v2.1-agent-first-harness`; keep `master` as the accepted baseline.
- Release v2.1.0 directly after acceptance; no prerelease is planned.
