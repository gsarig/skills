---
name: exit-session
description: "Saves anything from the current session worth keeping for next time, then confirms it is safe to /exit."
when_to_use: "Use when the user invokes /exit-session. Follow all steps in order; do not shortcut based on this description."
disable-model-invocation: true
---

## Steps

### 1. Answer the question

Treat the invocation as the user asking: "I want to close the session now. Do we need to write down anything before I leave, or am I good to hit /exit?" Work out the answer from this session's conversation, the same way you would if they had typed it. There is no fixed checklist.

### 2. Save what is worth keeping

Write down anything the next session would need but couldn't get from the code, git history or existing notes. Examples: a decision that was made, an open thread, a next step, a finding. Do it without asking. Put it where this task or project already keeps such notes (a notes or TODO file, `CLAUDE.md`, a ticket or issue, memory), following that place's conventions.

If saving something needs the user's input first (a decision only they can make, or something ambiguous), ask instead of writing it.

### 3. Report

If nothing was needed, reply with exactly `Good to /exit` and nothing else.

Otherwise, list what you saved and where, one line each. Also list anything you couldn't handle by writing a note that the user should know about before leaving, such as uncommitted changes or a background task that exiting would kill. End with `Good to /exit`, or with the question you need answered if step 2 raised one.

If this session spawned teammates (an agent team) that are still running, send each one a shutdown request and wait until every one confirms. Report this as one line of the list.

## What to avoid

- Writing a session recap. The transcript survives exit, so only save what is useful on its own next time.
- Saying "Good to /exit" without actually thinking about the session.
- Creating a new file when an existing note already fits.
