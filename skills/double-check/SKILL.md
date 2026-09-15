---
name: double-check
description: "Re-checks the immediately preceding reply for unverified claims, excess length, and overengineering, then re-issues a corrected reply."
when_to_use: "Use when the user invokes /double-check, or asks you to double-check, re-check, or verify your last reply ('double-check that', 'check your last answer', 'verify that reply'). With no argument, audit the most recent substantive reply. Do NOT use to investigate a new question from scratch (use investigate), to challenge a plan or design (use devils-advocate), or to review code (use the code-review skills). Follow all steps in order; do not shortcut based on this description."
argument-hint: "[optional pointer to a specific earlier reply]"
model: opus
effort: xhigh
---

## Steps

### 1. Identify the target and the model

Audit the reply the argument names; with no argument, the most recent substantive reply you gave. State in one line which reply you are auditing and which model you are running on. If the pin did not apply (you are not on Opus xhigh), say so before auditing: a self-audit that silently ran on a weaker model reads as authoritative when it is not.

### 2. List every factual claim in the reply

Extract each claim of fact (a value, a path, a behaviour, a "this is how it works"). Mark each as verified (you read the file, ran the command, or fetched the source, and can say which) or unverified (asserted without checking).

### 3. Re-verify any unverified claim now

For each unverified claim, check it against its primary source: read the file, run the command, fetch the source. Do not re-assert from memory. If a claim cannot be checked in this session, flag it as an unconfirmed hypothesis and name the single thing that would settle it.

### 4. Re-check against two standing rules

- **Brevity.** Could the reply say the same in fewer words? Prefer plain, jargon-free phrasing over technical register unless the reader needs it or asked for it. Cut anything that fails this test.
- **Don't overcomplicate.** Does the reply introduce edge cases, caveats, or extra machinery beyond what the question needed? A straightforward question gets a direct answer, not a multi-branch analysis; a proposed solution should be the smallest change that meets the need, with new abstractions justified only after showing that's insufficient. Cut what fails.

### 5. Re-issue the corrected reply

Produce the corrected reply. If a claim changed, name the evidence that flipped it; do not silently swap conclusions. If nothing needed correcting, say so in one line and stop.

## What to avoid

- **Re-asserting instead of checking.** An unverified claim re-stated with more confidence is still unverified.
- **Auditing the wrong reply silently.** State the target in step 1 so a wrong pick is caught immediately.
- **Manufacturing problems.** If the reply was verified and tight, say so and stop; do not invent objections to look rigorous.
