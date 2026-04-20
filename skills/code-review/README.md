# code-review

A Claude Code skill that reviews a pull request, a local diff or patch file, or staged files; detects and runs the project's lint script; and reports issues grouped by severity.

## What it does

When you ask for a code review, this skill determines what to review (a PR URL, a diff file, or staged changes), runs any detected linter (composer, npm, make), and produces a structured report. The report opens with a verdict (✅ Approved, 🔴 Request changes, or 💬 Comment), followed by issues numbered and grouped by severity: critical, medium, and minor. Security concerns unrelated to the change and project-wide observations are appended in separate sections at the end.

## Installation

Copy `SKILL.md` into your Claude Code skills directory:

```bash
mkdir -p ~/.claude/skills/code-review
cp SKILL.md ~/.claude/skills/code-review/SKILL.md
```

## Usage

- `/code-review` — reviews staged files
- `/code-review <PR URL>` — reviews a pull request
- `/code-review <path/to/file.diff>` — reviews a local diff or patch file
- Or just say "code review this" / "CR this" in a Claude Code session

## Requirements

For PR reviews, the `gh` CLI must be installed and authenticated.
