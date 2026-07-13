# devils-advocate

A Claude Code skill that produces a one-shot devil's-advocate critique of a plan, design, or decision: steel-manned strengths first, then severity-tagged findings each with a concrete alternative, then a verdict.

## What it does

When you ask Claude to challenge a plan, this skill calibrates the intensity of the critique to the stakes, steel-mans the plan before attacking it, audits the assumptions it rests on, stress-tests it with pre-mortem and inversion techniques, and reports strengths, findings (Critical/Major/Minor, each with a proposed mitigation or the thing that would resolve the uncertainty), and a one-line verdict. It explicitly guards against manufactured dissent: if the plan is sound, it says so.

## Installation

```bash
mkdir -p ~/.claude/skills/devils-advocate
cp SKILL.md ~/.claude/skills/devils-advocate/SKILL.md
```

## Usage

Say "play devil's advocate on this", "what's wrong with this plan?", or "challenge this approach" in a Claude Code session.

For an interactive one-question-at-a-time interrogation instead of a one-shot critique, use the [grill-me](../grill-me/) skill; the two are designed as companions.
