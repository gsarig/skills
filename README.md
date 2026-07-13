# skills

A collection of reusable [Claude Code](https://claude.ai/code) skills. These are skills I use in my own workflow that I think are generic enough to be useful beyond my specific setup.

## What are skills?

Skills are `SKILL.md` files that teach Claude Code how to handle specific tasks. Drop one into your `~/.claude/skills/<name>/` directory and Claude will pick it up automatically.

## Skills

| Skill | Description |
|-------|-------------|
| [claude-windows](skills/claude-windows/) | Compute the optimal Claude usage-window ping schedule from your work hours and register cloud routines that pin the window boundaries |
| [code-review](skills/code-review/) | Review a PR, diff file, or local changes: an orchestrator triages the change and dispatches to one of four specialized skills ([lite](skills/code-review-lite/), [deep](skills/code-review-deep/), [infra](skills/code-review-infra/), [content](skills/code-review-content/)) |
| [devils-advocate](skills/devils-advocate/) | One-shot devil's-advocate critique of a plan or design: steel-manned strengths, severity-tagged findings with alternatives, verdict |
| [grill-me](skills/grill-me/) | Stress-test a plan or design through a structured interview, one decision at a time. Inspired by [Matt Pocock](https://github.com/mattpocock/skills) |
| [investigate](skills/investigate/) | Investigate a question to a grounded conclusion where every claim is verified against a primary source or flagged as a hypothesis |
| [tldr](skills/tldr/) | Reduce a reply or text block to its core conclusion in the fewest words |
| [writing-skills](skills/writing-skills/) | Guide the creation or update of a `SKILL.md` file with the right structure and fields. [Read the backstory](https://www.gsarigiannidis.gr/on-writing-a-skill-about-writing-skills-for-claude-code/) |

## Installation

Each skill has its own README with installation instructions. The general pattern:

```bash
cp -r skills/<skill-name> ~/.claude/skills/
```

The `code-review` family installs as five folders (the orchestrator plus its four child skills); see [its README](skills/code-review/) for details.

## License

MIT
