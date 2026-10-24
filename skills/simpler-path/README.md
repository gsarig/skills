# simpler-path

A Claude Code skill that, just before a plan or brief is drafted, raises up to three one-line hunches about how the approach could be simpler, so you can pick any worth discussing before anything is written.

## What it does

NASA spent millions on a pen that writes in zero gravity; the Russians used a pencil. This skill proposes the pencil. It restates the underlying need in one line, looks for the most practical way to meet it, then scans the planned approach for extras: assumed requirements, guards against unconfirmed risks, workarounds where a stop-check would do, code where a manual step would do, and existing behaviour that already covers part of it. Each hunch comes with its likely cost, and you pick which ones to explore in a multi-select question. "Nothing worth raising" is a normal result.

It does no new research and works only from what is already in context, so it is cheap to run. Planning or briefing skills can call it by name at the point where their questions are answered and drafting is next.

## Installation

```bash
mkdir -p ~/.claude/skills/simpler-path
cp SKILL.md ~/.claude/skills/simpler-path/SKILL.md
```

## Usage

- `/simpler-path` checks the approach currently under discussion
- `/simpler-path <approach or draft>` checks a specific one
- Or ask "is there a simpler path?", "could this be simpler?"
- From another skill: call `simpler-path` by name right before drafting

It is not a critique of a finished plan (use [devils-advocate](../devils-advocate/)) or a re-check of a reply (use [double-check](../double-check/)).

The backstory behind this skill is in [this blog post](https://www.gsarigiannidis.gr/nasa-spent-millions-on-a-pen-that-writes-in-zero-gravity-the-russians-used-a-pencil/).
