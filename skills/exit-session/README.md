# exit-session

A Claude Code skill that saves anything from the current session worth keeping for next time, then confirms it is safe to `/exit`.

## What it does

Before you close a session, this skill answers one question: "Do we need to write anything down, or am I good to leave?" It looks at what happened in the session and saves only what the next session would need but couldn't recover from the code, git history or existing notes (a decision, an open thread, a next step), putting it wherever the project already keeps such notes. It also flags anything that exiting would lose, such as uncommitted changes or a running background task. It never writes a session recap, since the transcript survives exit. When nothing needs saving, the whole reply is `Good to /exit`.

## Installation

```bash
mkdir -p ~/.claude/skills/exit-session
cp SKILL.md ~/.claude/skills/exit-session/SKILL.md
```

## Usage

- `/exit-session` before closing a session

The skill sets `disable-model-invocation: true`, so it runs only when you type the command, never on its own.
