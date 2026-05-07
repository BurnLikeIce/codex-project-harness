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

## New Project Startup

Treat similar expressions as project startup with this conversation as master/control:

- "Start a new project with project-harness."
- "Use project-harness to begin this project; this is the master conversation."
- "Set this project up with the harness."
- "Initialize this project workflow."
- "This conversation should be the project control conversation."

For high confidence, install/check harness files, inspect Git, and make this conversation master/control. If Git initialization or GitHub remote setup is needed and not explicitly requested, ask before doing it.

## Existing Project Takeover / Migration

Treat similar expressions as existing project migration using `docs/migration.md`:

- "Take over this existing project with project-harness."
- "Migrate this old project into the harness."
- "This conversation is the master for this existing project."
- "Bring this project under project-harness."
- "Normalize this project with the harness."

For high confidence, inspect first and produce a migration plan. Do not overwrite existing docs or change business code before user approval.

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
