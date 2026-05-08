# Acceptance and Rework Template

Use this document when the product/architecture conversation reviews results from frontend, backend, bugfix, or experiment conversations.

## Acceptance Rule

Every review must end with one of these decisions:

- `Accepted`
- `Rejected`
- `Conditionally Accepted`

Every review must also include next-step handoff:

- Accepted: provide copy-ready instructions for the master/control conversation.
- Rejected: state failed points, provide copy-ready rework instructions, and tell master not to merge.
- Conditionally Accepted: state conditions, provide copy-ready follow-up instructions, and tell master not to merge until conditions are satisfied.

Do not stop at "accepted" or "rejected".

## Output Format

```md
## Task Acceptance: <Task ID>

Decision: Accepted / Rejected / Conditionally Accepted

Acceptance Reasoning:
- <why this is accepted, rejected, or conditionally accepted>

Failed Points / Conditions:
- <write "None" if accepted>

Responsible Rework Conversation:
- <write "None" if accepted>
- <Frontend / Backend / Bugfix / Experiment / Other when rework is needed>

Docs To Update:
- [ ] `docs/tasks.md`
- [ ] `docs/product.md`
- [ ] `docs/api-contract.md`
- [ ] `docs/architecture.md`
- [ ] `docs/decisions.md`

Copy-Ready Instruction For Rework Conversation:

```text
<None if accepted>
```

Copy-Ready Instruction For Master Conversation:

```text
<Required for every decision>
```
```

## Accepted Example

```text
FE-001 is accepted.

Acceptance reasoning:
- Page behavior matches the acceptance criteria in docs/tasks.md.
- Empty, loading, and error states are covered.
- Delivery matches product expectations.

Failed points / conditions:
- None

Responsible rework conversation:
- None

Copy-ready instruction for rework conversation:

None

Copy-ready instruction for master conversation:

Please continue FE-001 with master review and pre-merge verification.

Product acceptance has passed.

Please:
- Inspect the FE-001 branch/PR diff.
- Run the relevant tests, lint, and build.
- Confirm docs/tasks.md can be updated.
- If verification passes, merge through the project PR flow.
- After merge, mark FE-001 as Done and update docs/changelog.md.
```
