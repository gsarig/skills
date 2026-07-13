# investigate

A Claude Code skill that investigates a question to a grounded conclusion in which every claim is either verified against a primary source or explicitly flagged as an untested hypothesis.

## What it does

When you ask Claude to get to the bottom of something, this skill forces the discipline that ad-hoc investigation tends to skip: re-fetching context from the source instead of memory, grounding claims in primary sources rather than proxies (comments, summaries, variable names), reproducing runtime claims before stating them, checking available tools before declaring something unverifiable, handing over checks that are legitimately someone else's to run, and tagging every claim in the conclusion as verified (with how) or inferred (with what would confirm it).

## Installation

```bash
mkdir -p ~/.claude/skills/investigate
cp SKILL.md ~/.claude/skills/investigate/SKILL.md
```

## Usage

- `/investigate why does the build fail on CI but not locally?`
- Or say "get to the bottom of this", "is this actually a bug?", or "are you sure?" in a Claude Code session.
