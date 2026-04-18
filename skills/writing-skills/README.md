# writing-skills

A Claude Code skill that guides the creation or update of a `SKILL.md` file: picks the right frontmatter fields, drafts the skill body, runs pressure tests, and waits for your approval before writing anything.

## What it does

When you ask Claude to write or update a skill, this skill takes over and runs a structured workflow: clarifying the trigger condition, choosing the right scope and frontmatter fields, drafting the body with the correct structure, running two mental pressure tests to catch common failure modes, presenting the draft for approval, and only then writing the file.

## Installation

Copy `SKILL.md` into your Claude Code skills directory:

```bash
mkdir -p ~/.claude/skills/writing-skills
cp SKILL.md ~/.claude/skills/writing-skills/SKILL.md
```

## Usage

Say "write a skill for X" or "create a skill that does Y" in a Claude Code session.

## Attribution

The backstory behind this skill is in [this blog post](https://www.gsarigiannidis.gr/on-writing-a-skill-about-writing-skills-for-claude-code/). The key insight that `description` should contain only triggering conditions and never summarize the skill's workflow (because agents shortcut-follow the summary instead of reading the full skill) comes from Jesse Vincent's [superpowers](https://github.com/obra/superpowers) framework, discovered through [this review](https://ai-resources.gsarigiannidis.gr/reviews/superpowers/). The rest of the structure, field taxonomy, and pressure-testing approach were developed independently for Claude Code's SKILL.md format. More context on the workflow that produced that review is in [this blog post](https://www.gsarigiannidis.gr/claude-code-obsidian-ai/).
