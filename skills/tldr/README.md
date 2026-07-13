# tldr

A Claude Code skill that reduces a target to the tip of the inverted pyramid: its core conclusion in a short paragraph, dropping supporting detail and reasoning, then tightened to the fewest words.

## What it does

When you ask for the bottom line, this skill finds the single core conclusion of the target (a prior reply, a pasted block, a named section), drops everything below it in the pyramid, and then iteratively strips words until nothing can be removed without losing meaning, while keeping natural full-sentence prose rather than telegraphic fragments. The output is the tip and nothing else: no preamble, no label, no closing offer.

## Installation

```bash
mkdir -p ~/.claude/skills/tldr
cp SKILL.md ~/.claude/skills/tldr/SKILL.md
```

## Usage

- `/tldr` reduces the preceding reply
- `/tldr <text>` reduces the given text
- Or say "give me the gist", "bottom line", or "in short" in a Claude Code session.
