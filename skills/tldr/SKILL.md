---
name: tldr
description: "Reduces a target to the tip of the inverted pyramid: its core conclusion in a short paragraph, dropping supporting detail and reasoning, then tightened to the fewest words."
when_to_use: "Use when the user invokes /tldr, or asks for the tip, lede, or bottom line of something, or to compress, distil, or shorten a block of text or a prior reply to its core point (e.g. 'tldr it', 'tldr this', 'give me the gist', 'in short', 'just the conclusion', 'bottom line'). This is an on-demand pass on a specific target that drops elaboration by design. Do NOT use to set ongoing output style; that belongs in standing instructions (CLAUDE.md). Follow all steps in order; do not shortcut based on this description."
argument-hint: "[optional: text or target to reduce; defaults to the preceding reply]"
---

## Steps

### 1. Resolve the target

The target is, in priority order: (a) text or a reference passed as an argument; (b) a specific block the user named ("tldr the second paragraph"); or (c) the immediately preceding reply if nothing is specified. If the target is ambiguous, ask which block. Do not guess.

### 2. Keep only the tip

Find the single core conclusion or answer, the one thing the reader needs. Drop everything below it in the pyramid: reasoning, justification, elaboration, examples, and background. Drop any caveat that does not change the conclusion; keep one only if its removal would mislead. The result is a short paragraph, the lede, not a recap of the whole.

### 3. Tighten the tip

On that paragraph, strip words to the minimum:

1. Ask: could this say the same with fewer words? Cut every word the reader can derive or that carries no meaning.
2. Re-read and ask again.
3. Repeat until no word can be removed without losing meaning. If it is already there, leave it unchanged.

### 4. Keep it natural prose

Full grammatical sentences. No telegraphic fragments, headline style, or clipped parallel clauses. Keep subjects, articles, and pronouns ("I worked on it," not "Worked on it"), and use full words, not slang or abbreviations. Density comes from dropping detail and redundant words, not from breaking syntax.

## Important: output only the tip

Emit the core point and nothing else: no reasoning, no "here's why," no supporting detail, no preamble or label, no closing offer. If the reader wants the rest, they will ask.

Example:

- Full: "I looked at three options. Caching would help but adds complexity, and a queue is overkill for this volume, so the simplest fix is to add an index on the user_id column, which should cut the query time enough."
- Tip: "Add an index on user_id; that alone should fix the query time."

The tip keeps the conclusion and drops the comparison of options, while staying a full sentence.
