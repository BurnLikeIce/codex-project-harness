# Acceptance and Rework Template

Use this document when the product/architecture conversation reviews results from frontend, backend, bugfix, or experiment conversations. The usual workflow is: the user pastes another conversation's result summary, screenshots, PR summary, test output, or notes into the product conversation, then the product conversation returns an acceptance decision and copy-ready next-step instructions.

## Acceptance Rule

Every review must end with one of these decisions:

- `Accepted`
- `Rejected`
- `Conditionally Accepted`

If the result is not fully accepted, explicitly state what failed and provide instructions the user can copy directly into the responsible conversation. Do not stop at "not good enough" or "does not pass".

## Output Format

```md
## Task Acceptance: FE-001 / BE-001 / BUG-001

Decision: Accepted / Rejected / Conditionally Accepted

Failed Points:
- State exactly what does not match the requirement, acceptance criteria, or product expectation.
- List each issue separately.

Responsible Conversation:
- Frontend / Backend / Master / Product / Bugfix / Experiment

Docs To Update:
- [ ] `docs/tasks.md`
- [ ] `docs/product.md`
- [ ] `docs/api-contract.md`
- [ ] `docs/architecture.md`
- [ ] `docs/decisions.md`

Copy-Ready Instruction For The Responsible Conversation:

```text
Please continue FE-001.

Product acceptance failed because:
- ...
- ...

Please complete this rework:
- ...
- ...

Requirements:
- Continue on the current branch/worktree.
- Update the relevant docs if API or product behavior changes.
- Run the relevant verification, then return the result to the master/product conversation for re-acceptance.
```

Master Conversation Next Step:
- Do not merge the related PR until rework is complete.
- Mark the task as `In Progress` or `Rework`.
```

## Accepted Example

```text
FE-001 is accepted.

Why:
- The page behavior matches the acceptance criteria in docs/tasks.md.
- Empty, loading, and error states are covered.
- Screenshots match the product expectation.

Master conversation next step:
- Proceed to PR review and pre-merge verification.
- Mark FE-001 as Done after merge.
```

## Rejected Example

```text
FE-001 is rejected.

Failed points:
- Mobile layout overflows horizontally at 390px width.
- Empty state is missing when the user has no data.
- Dashboard card fields do not match docs/product.md.

Responsible conversation:
- Frontend

Docs to update:
- [ ] docs/tasks.md

Copy-ready instruction for the frontend conversation:

Please continue FE-001.

Product acceptance failed because:
- Mobile layout overflows horizontally at 390px width.
- Empty state is missing.
- Dashboard card fields do not match docs/product.md.

Please complete this rework:
- Fix the mobile layout so there is no horizontal scrolling at 390px width.
- Add the empty state.
- Adjust dashboard card fields to match docs/product.md.
- Run lint/build and return the result to the master and product conversations for re-acceptance.

Master conversation next step:
- Do not merge the FE-001 PR until rework is complete.
- Mark FE-001 as Rework.
```
