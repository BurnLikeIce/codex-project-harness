# Intent Recognition

Use this document when the user speaks naturally instead of using exact short commands.

This is intent recognition, not hard string matching. If the user's wording is close to one of the intents below, follow the matching workflow.

## Requirement Clarification

Treat similar expressions as `New requirement: ...`:

- "I want to discuss whether this can be done."
- "I have an idea."
- "Can this feature work?"
- "Is this worth building?"
- "Let's think through this first."
- "Help me look at this requirement."

For high confidence, enter requirement clarification directly. For medium or low confidence, ask one short confirmation question before proceeding.

## Requirement Dispatch

Treat similar expressions as `Requirement discussion is done. Please dispatch tasks.`:

- "Let's do it this way."
- "Start building based on this."
- "Let's move forward."
- "Arrange the tasks."
- "Split this up."
- "Let frontend/backend start."

Do not skip task docs or dispatch. Product conversation must update docs and output copy-ready task instructions.

## Issue Triage

Treat similar expressions as `Issue: ...`:

- "This looks wrong."
- "Something is off here."
- "Why does this behave like this?"
- "This may be a bug."
- "Clicking this does nothing."
- "This display is wrong."

The receiving conversation should use `docs/triage.md` to classify, record, handle, or escalate the issue.

## Safety Rule

If intent is unclear:

- Do not silently start implementation.
- Ask one concise confirmation question.
- Offer the likely choices, such as requirement discussion, issue triage, or direct small fix.

If the user says "start" or "go ahead" before tasks are clear, product conversation must dispatch tasks first.

If a user reports an issue to the wrong conversation, that conversation should route it using `docs/triage.md`; the user does not need to know the correct destination first.
