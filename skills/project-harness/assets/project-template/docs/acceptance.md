# Acceptance

Use this document when the product/architecture conversation reviews work from frontend, backend, bugfix, or experiment conversations.

## Acceptance Rule

Every review must end with one of these decisions:

- `Accepted`
- `Rejected`
- `Conditionally Accepted`

If the result is not fully accepted, the product/architecture conversation must produce actionable next steps. Do not stop at "not good enough" or "does not pass".

## Review Template

```md
## YYYY-MM-DD Task Acceptance

Task:
Reviewer:
Decision: Accepted / Rejected / Conditionally Accepted

Reviewed Evidence:
- PR or branch:
- Screenshots or demo:
- Test/build result:
- Relevant docs:

Acceptance Criteria Checked:
- [ ] Criterion 1
- [ ] Criterion 2

Findings:
- 

Required Rework:
- Owner: Frontend / Backend / Master / Product / Bugfix / Experiment
- Task ID: FE-001 / BE-001 / BUG-001
- Instructions:
  - 

Docs To Update:
- [ ] `docs/tasks.md`
- [ ] `docs/product.md`
- [ ] `docs/api-contract.md`
- [ ] `docs/architecture.md`
- [ ] `docs/decisions.md`

Next Handoff:
Frontend: read prompts/frontend.md and continue FE-001 from docs/tasks.md.
Backend: read prompts/backend.md and continue BE-001 from docs/tasks.md.
Master: keep the PR unmerged until rework is complete.
```

## Handoff Examples

```text
FE-001 is rejected.

Reason:
- Mobile layout does not meet the acceptance criteria.
- Empty state is missing.

Frontend rework:
- Continue FE-001 on the current branch.
- Read the Rework Notes in docs/tasks.md.
- Fix mobile layout and empty state.
- Run lint/build and return to master for review.
```

```text
BE-001 is conditionally accepted.

Condition:
- Add a test for the missing error response case before merge.

Backend next step:
- Continue BE-001 on the current branch.
- Add test coverage for the documented error response.
- Update docs/api-contract.md if the response shape changes.
```
