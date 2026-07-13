# claude-windows

A Claude Code skill that computes the optimal Claude usage-window ping schedule from your work hours and registers scheduled cloud routines that pin the window boundaries in place.

## What it does

Claude usage limits operate on rolling 5-hour windows that start with your first message. If a window opens at an awkward time, its usable span inside your workday shrinks. This skill computes where the window boundaries should fall for a given workday (splitting the slack between morning and evening via an `alpha` parameter), presents the plan for approval, and then creates cloud routines (via Claude Code's `/schedule` mechanism) that send a throwaway ping at each boundary so the windows always start where you want them.

Defaults are read from environment variables you can set in your `settings.json` `env` block:

- `CLAUDE_WINDOWS_HOURS` (e.g. `11:00-19:00`)
- `CLAUDE_WINDOWS_ALPHA` (default `0.5`; share of the slack given to the morning)
- `CLAUDE_WINDOWS_DAYS` (default `1-5`; cron day-of-week field)

## Installation

```bash
mkdir -p ~/.claude/skills/claude-windows
cp SKILL.md ~/.claude/skills/claude-windows/SKILL.md
```

## Usage

- `/claude-windows` uses the stored defaults
- `/claude-windows 09:00-17:00` recomputes for new hours (and offers to persist them)
- `/claude-windows 09:00-17:00 0.7` also adjusts the morning/evening split

## Requirements

Claude Code with scheduled cloud routines available (the `/schedule` feature). The routines run in Anthropic's cloud, so nothing needs to stay running on your machine.
