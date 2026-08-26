---
name: layman
description: "Explains any target (a ticket, a file, a concept, or whatever is under discussion) the way you would explain it to a smart teenager, in a few plain sentences."
when_to_use: "Use when the user types /layman, or asks for a plain-English, 'explain it like I'm a teenager' rundown of something for their own understanding. The target is the argument, or the thing currently under discussion. Answer in chat unless the user asks for it in a file. Do NOT use for stakeholder- or client-facing summaries (they need scrubbing, not candour), or for compressing an existing block of text (use /tldr). Follow all steps in order; do not shortcut based on this description."
argument-hint: "[what to explain; defaults to the current topic]"
---

## Steps

### 1. Fix the target

Explain whatever the argument names, or the thing under discussion when there is no argument. If it is unclear what the user means, ask before writing.

### 2. Explain it like you would to a smart teenager

Cover what it is and the one or two things that actually matter about it.

### 3. Answer in chat, unless asked for a file

Reply in chat by default. Write to a file only when the user asks, at the path they give.
