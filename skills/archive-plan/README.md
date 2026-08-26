# archive-plan

A Claude Code skill that retires a finished plan document: it establishes from real artifacts what actually shipped, never from the plan's own status line, then files the plan under `plans/archive/` with that record.

## What it does

Plans almost always still claim to be a draft after the work is done, since nobody goes back to update the header on the way out. This skill treats that header as unverified prose and rebuilds the truth from a deliverable-by-deliverable check against real artifacts (`present`, `absent`, or `could not verify`, with no rounding up). It then triages the plan to one of four dispositions (archive only, generalised already, abandoned or superseded, or warrants a playbook), proposes the evidence and the exact file moves, and only archives on explicit approval. If the plan's procedure repeats on new targets, it can write a generalised playbook as a separate, second approval.

Model invocation is disabled by default (`disable-model-invocation: true`), so it only runs when you call it directly.

## Installation

```bash
mkdir -p ~/.claude/skills/archive-plan
cp SKILL.md ~/.claude/skills/archive-plan/SKILL.md
```

## Usage

- `/archive-plan <path or name>` archives a specific plan
- `/archive-plan` with no argument searches `plans/`, `tmp/`, `docs/`, then the project root for a plan-shaped document
- Or say "archive this plan", "this plan is done, file it away", or similar.
