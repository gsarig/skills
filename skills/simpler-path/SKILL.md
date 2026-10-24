---
name: simpler-path
description: "Before a plan or brief is drafted, raises up to three one-line hunches about how the approach could be simpler, so the user can pick any worth discussing before anything is written."
when_to_use: "Use when a planning or briefing skill reaches the point where its questions are answered and drafting is next; those skills call it by name at that step. Also use when the user invokes /simpler-path, or asks about an approach under discussion: 'is there a simpler path?', 'is there a simpler way?', 'could this be simpler?'. Do NOT use to critique a finished plan or design (use devils-advocate), to re-check a reply (use double-check), or to clean up code (use simplify or code-review). Follow all steps in order; do not shortcut based on this description."
argument-hint: "[optional: the approach or draft to check; defaults to what the caller has in context]"
---

## Important

Think of the apocryphal joke: NASA spent millions on a pen that writes in zero gravity; the Russians used a pencil. This skill's job is to propose the pencil: the practical alternative, with its likely cost. The pen may still be the right call; the user decides.

This is a quick scan that produces questions, not an investigation that produces solutions. Do no new research: work only from what is already in context. The principle behind it: default to the smallest change that meets the need, and add new machinery only after showing that the minimal change is insufficient.

## Steps

### 1. Look for the practical alternative first

State the underlying need in one line (e.g. "write in zero gravity", not "build a pen"). Then ask what the most practical, pragmatic way to meet it would be, even if it replaces the planned approach rather than trimming it.

### 2. Scan the approach for extras

Then look for spots where the approach may do more than needed:

- **A requirement you assumed** rather than one the ticket, brief or user's answers asked for.
- **A guard against a risk nobody confirmed**, including risks carried over from an earlier artifact or another agent.
- **A workaround where a simple stop-check might do**: failing the run up front instead of building around the problem.
- **Code where a simple manual step would do**: fixing a handful of entries by hand instead of writing a migration script; checking once for a case that probably has no data (e.g. content by users who don't write content) and handling any leftover by hand, instead of coding for it.
- **Existing behaviour that may already cover part of it.**

A rename, a reshuffle, or anything that isn't simpler or cheaper overall does not count. Keep at most three hunches across steps 1 and 2.

### 3. If nothing stands out, say so and hand back

"Nothing worth raising" is a normal result. Say it in one chat line and return to the caller. Never invent a hunch that isn't actually simpler, but never hold back a practical alternative because the planned approach may still win; the user decides that.

### 4. Ask which hunches are worth exploring

Ask one multi-select question through AskUserQuestion: "Which of these are worth exploring?" Each option is one hunch: a short label (e.g. "Use a pencil") and a description phrased "We could <practical alternative>, but <likely cost, or 'cost unclear'>." (e.g. "We could use a pencil, but graphite dust may float into the electronics."). Mark each as a hunch; do not verify it first. Flag any hunch that changes what was asked as a scope change, not a simplification. Add a "None" option.

### 5. Discuss the picks, then hand back

For each hunch the user picks, discuss it right then in conversation: check what is needed to settle it, and agree whether it changes the approach. Then return the agreed approach to the caller. On "None", return the approach unchanged.
