# grill-me

A Claude Code skill that interviews you relentlessly about a plan or design, resolving dependent decisions one branch at a time and recommending an answer for each question.

## What it does

When you say "grill me" or ask Claude to stress-test a plan, this skill takes over and runs a structured interview: one question at a time, each with a recommendation, walking down the decision tree and resolving dependencies before moving on. If a question can be answered by reading the codebase, it does that instead of asking.

## Installation

Copy `SKILL.md` into your Claude Code skills directory:

```bash
mkdir -p ~/.claude/skills/grill-me
cp SKILL.md ~/.claude/skills/grill-me/SKILL.md
```

## Usage

Just say "grill me" or "stress-test this plan" in a Claude Code session.

## Attribution

Inspired by Matt Pocock's [grill-me skill](https://github.com/mattpocock/skills), expanded with structured steps and explicit rules for recommendation quality and codebase exploration.
