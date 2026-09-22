---
name: writing-artifacts
description: "Runs a mechanical hygiene pass over a drafted Markdown artifact so it reads standalone and stays tight, amending presentation only and never touching the substance."
when_to_use: "Use on a Markdown artifact just before it is finalised: invoked by another skill that produces a draft before presenting it, or invoked directly via /writing-artifacts or a request to clean a drafted artifact. Do NOT use to judge the artifact's substance, challenge its approach, or suggest a different solution (that is code-review or devils-advocate). Do NOT use on chat replies. Follow all steps in order; do not shortcut based on this description."
argument-hint: "[path to the drafted artifact, or the draft handed in context]"
---

## Important: this is a hygiene pass, not a review

This skill only makes a finished artifact read cleanly to someone who was not in the conversation. It never evaluates whether the artifact is right. If a plan proposes an approach, this skill does not challenge the approach, propose an alternative, add missing content, or correct a claim's substance. It scans for a fixed set of presentation faults and amends only those. Substance is out of scope, full stop. When a fix would require changing what the artifact actually says or recommends, do not make it: flag it back to the caller and move on.

## Steps

### 1. Get the draft

- **Producer-invoked:** the draft is already in context. Run this pass on it *before* the producing skill presents the draft to the user, so the user reviews and approves the cleaned version. Never run it between the user's approval and the save; the file that lands must be the file that was approved.
- **Standalone (a file path was given):** read the whole file first, then amend it in place.

### 2. Scan A: does it read standalone?

The reader was not in this conversation, so every sentence must make sense to them. Two failure modes, both fixed by cutting or rephrasing to the plain current statement.

- **Process narration.** Test each candidate: is the sentence about the *author's route to the answer*, or about the *subject*? If it narrates the drafting, changing beliefs, corrections, the path taken, cut it and keep only the conclusion it wrapped. Always cut: "my first instinct", "on reflection", "as I said", "as noted above/earlier", "I got it wrong", "I moved position", "this is where I". Judge by the test, do not blanket-cut: "initially", "at first" are ordinary content words as often as not ("initially the cache is empty"). This is not a ban on first person: "I refactored X", "I found Y" are legitimate statements of fact. Write for the reader who receives the file, not the person you were talking to while drafting it.
- **Dangling references.** Pointers to things the reader cannot reach: private or local paths, filenames only you have, "per the earlier draft", "as we discussed", "the backlog". Replace with the fact stated self-contained, or cut. Every claim in the artifact must hold for whoever actually reads it; a reference only you can resolve is false to them, not merely unhelpful.

### 3. Scan B: remove only padding

At the sentence level, remove **only** restatement of something the artifact already said and syntactic padding ("it is worth noting that", "in order to" → "to"). Everything else is out of scope. A sentence stating a limit, condition, or confidence level is meaning whatever its wording ("on Chrome only", "assuming the cap holds", "probably"), so never trim it; if it still reads as padding, flag it back per step 5 rather than cutting. Defer to the producing skill's own length ceiling where it sets one.

### 4. Scan C: AI writing tics

- **Staccato-then-payoff.** A run of short parallel conjunction-free sentences followed by a longer "payoff" sentence. This is an overused AI writing crutch; rewrite with natural variation instead of imposing any default rhythm.
- **Hard-wrapped prose.** Paragraphs broken at a fixed column width. Rejoin each into one logical line. **Never rejoin across a structural boundary:** inside YAML frontmatter, a fenced code block, a table, a callout, a footnote definition, or a list item's continuation. Leave those exactly as they are.
- **Inline command sequences.** Two or more runnable shell commands the reader runs in order, presented inline in backticks or prose. Move them into a fenced code block, one command per line, one block per step. Reformat only: do not add, reword, or comment the commands.

### 5. Amend, then hand back

Apply the fixes from Scans A to C, changing wording only. If a flagged item cannot be fixed without altering substance, leave it and note it for the caller.

- **Producer-invoked:** return the cleaned draft for that skill to present and then save. Do not write the file yourself; the producing skill owns the save.
- **Standalone:** apply the edits to the file in place.

Report in one line what was amended (e.g. "cut 2 process-narration sentences, rejoined 3 wrapped paragraphs"), or "clean, no changes". Do not restate the artifact.

## What to avoid

- **Do not challenge the approach or add content.** This is the single most important boundary. Hygiene only.
- **Do not strip legitimate first person.** Only process-of-drafting narration is in scope, not "I did X" statements of fact.
- **Do not cut a sentence stating a limit, condition, or confidence level.** That is meaning whatever its wording; keep it.
