# skills

A collection of reusable [Claude Code](https://claude.ai/code) skills. These are skills I use in my own workflow that I think are generic enough to be useful beyond my specific setup.

## What are skills?

Skills are `SKILL.md` files that teach Claude Code how to handle specific tasks. Drop one into your `~/.claude/skills/<name>/` directory and Claude will pick it up automatically.

## Skills

| Skill | Description |
|-------|-------------|
| [code-review](skills/code-review/) | Review a PR, diff file, or staged changes; run the project linter; report issues by severity |
| [grill-me](skills/grill-me/) | Stress-test a plan or design through a structured interview, one decision at a time. Inspired by [Matt Pocock](https://github.com/mattpocock/skills) |
| [writing-skills](skills/writing-skills/) | Guide the creation or update of a `SKILL.md` file with the right structure and fields |

## Installation

Each skill has its own README with installation instructions. The general pattern:

```bash
mkdir -p ~/.claude/skills/<skill-name>
cp skills/<skill-name>/SKILL.md ~/.claude/skills/<skill-name>/SKILL.md
```

## License

MIT
