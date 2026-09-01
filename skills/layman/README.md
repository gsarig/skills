# layman

A Claude Code skill that explains a target the way you'd explain it to a smart teenager: a few plain sentences, no jargon, no padding.

## What it does

Point it at a ticket, a file, a concept, or whatever's currently under discussion, and it covers what the thing is plus the one or two things that actually matter about it. It answers in chat by default. This is for your own understanding, not for scrubbing a message down for a stakeholder or client audience, and it doesn't compress existing text (that's [tldr](../tldr/)).

## Installation

```bash
mkdir -p ~/.claude/skills/layman
cp SKILL.md ~/.claude/skills/layman/SKILL.md
```

## Usage

- `/layman` explains the current topic
- `/layman <target>` explains the named ticket, file, or concept
- Or just ask for a plain-English, "explain it like I'm a teenager" rundown.

## Attribution

The backstory behind this skill is in [this blog post](https://www.gsarigiannidis.gr/explain-it-to-me-like-im-a-smart-teenager/).
