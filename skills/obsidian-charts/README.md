# obsidian-charts

A Claude Code reference skill for building charts inside Obsidian `dataviewjs` blocks.

## What it does

Chart code in `dataviewjs` fails in ways that are specific to that environment and hard to guess, so Claude tends to write plausible code that silently does nothing. This skill supplies the working patterns: when to emit a YAML ` ```chart ``` ` block versus calling `window.renderChart` directly, a Chart.js v3 plugin for drawing values above bars, how to pick the container element for one chart versus several in the same block, a default colour palette, and the pitfalls (`dataLabels: true` is silently ignored by the plugin, `\n` in a JS string literal breaks block parsing, Dataview's `DataArray` is not a plain array, `chartjs-plugin-datalabels` is not bundled).

This is background knowledge rather than a workflow: Claude loads it when it sees chart code in a `dataviewjs` block, and you never need to invoke it.

## Requirements

The [Obsidian Charts](https://github.com/phibr0/obsidian-charts) plugin (phibr0) and [Dataview](https://github.com/blacksmithgu/obsidian-dataview), both installed and enabled in the vault.

## Installation

```bash
mkdir -p ~/.claude/skills/obsidian-charts
cp SKILL.md ~/.claude/skills/obsidian-charts/SKILL.md
```

## Usage

None. Claude reads it automatically when working on chart code in a `dataviewjs` block.
