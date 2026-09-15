# double-check

A Claude Code skill that re-checks the immediately preceding reply for unverified claims, excess length, and overengineering, then re-issues a corrected version.

## What it does

Runs a self-audit on your own last reply: lists every factual claim, marks each as verified or unverified, and re-checks the unverified ones against a primary source (a file, a command, a fetched page) instead of re-asserting from memory. Then checks the reply against two standing rules, brevity and not overcomplicating, and re-issues a corrected reply if anything failed either check. Pinned to `model: opus` and `effort: xhigh` by default, since a self-audit is only worth as much as the model running it.

## Installation

```bash
mkdir -p ~/.claude/skills/double-check
cp SKILL.md ~/.claude/skills/double-check/SKILL.md
```

## Usage

- `/double-check` audits the most recent substantive reply
- `/double-check <pointer>` audits a specific earlier reply
- Or say "double-check that", "check your last answer", "verify that reply"
