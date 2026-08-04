# writing-instructions

A Claude Code skill that guides writing or revising a behavioral rule in your instruction files, so it lands in the right scope, doesn't duplicate or contradict an existing rule, and stays lean.

## What it does

The companion to [writing-skills](../writing-skills/): that one shapes a `SKILL.md`, this one shapes a rule in a `CLAUDE.md` or a situational topic file. It starts from the premise that most proposed rules should not be written, and gates on that first: a rule with no observable trigger, one incident that won't recur, or something an existing rule already covers gets rejected or redirected rather than added. What survives the gate is then placed by how often it is actually needed (a narrow rule in an always-loaded file is noise paid every session), deduped against neighbouring rules, checked for contradictions, and written tight.

## Installation

```bash
mkdir -p ~/.claude/skills/writing-instructions
cp SKILL.md ~/.claude/skills/writing-instructions/SKILL.md
```

## Usage

- `/writing-instructions always run the linter before committing`
- Or say "add a rule that...", "put this in CLAUDE.md", or invoke it after a correction surfaces a lesson worth making permanent.
