# Completion and Acceptance

## Implementation Return

Use a proportional return containing:

- task reference or concise outcome;
- completed scope;
- files or contracts changed when relevant;
- verification performed and observed result;
- remaining risks, assumptions, or omissions;
- readiness for acceptance.

Visual evidence, screenshots, logs, links, commits, or test output are optional evidence types, not universal requirements. Request only evidence that can verify the recorded criteria.

## Acceptance Result

Return exactly one status and always include the next control action.

### Accepted

State which criteria and evidence passed, identify residual risk, and say whether the next action is integration, broader verification, release preparation, another task, or closure.

### Rework required

For each failure, state:

- the criterion that failed;
- observed evidence;
- expected behavior;
- responsible execution context;
- a directly usable rework instruction containing scope, constraints, and verification.

### Blocked

State the missing dependency or decision, its owner, what can continue safely, and the exact unblocking action.

### Superseded

State the replacing task or decision and what should happen to existing work.

## Control Instruction

Acceptance is not complete when it only says pass or fail. It must tell the control context what to do next and which durable records need to change.
