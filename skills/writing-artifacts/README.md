# writing-artifacts

A Claude Code skill that runs a mechanical hygiene pass over a drafted Markdown artifact so it reads standalone and stays tight, before it's finalised.

## What it does

Scans a drafted artifact (a plan, a report, any Markdown document meant to be read by someone who wasn't in the conversation that produced it) for a fixed set of presentation faults and fixes only those: process narration ("on reflection...", "as I said earlier...") left over from drafting, dangling references to things only you can see, padding, and common AI writing tics (staccato-then-payoff rhythm, hard-wrapped paragraphs, inline command sequences that belong in a fenced code block). It never touches substance: it won't challenge the artifact's approach, add content, or correct a claim, only flag it back if a fix would require doing so.

Designed to be called by another skill right before it presents a draft for approval, but works standalone against any file path too.

## Installation

```bash
mkdir -p ~/.claude/skills/writing-artifacts
cp SKILL.md ~/.claude/skills/writing-artifacts/SKILL.md
```

## Usage

- `/writing-artifacts <path>` cleans a drafted artifact in place
- Invoked automatically by another skill right before it presents a finished draft
- Or ask to clean up a drafted document
