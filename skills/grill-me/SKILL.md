---
name: grill-me
description: "Interviews the user branch-by-branch about a plan or design, resolving dependent decisions one at a time and recommending an answer for each question."
when_to_use: "Use when the user asks to be grilled on a plan, says 'grill me', or wants to stress-test a design before implementation. Follow all steps in order; do not shortcut based on this description."
model: opus
effort: high
---

## Steps

### 1. Walk the decision tree one branch at a time

Interview the user relentlessly about every aspect of the plan or design until you reach shared understanding. Resolve dependent decisions sequentially, not in parallel; later branches often depend on how earlier ones were answered.

### 2. Recommend an answer for each question

When you pose a question, include your recommended answer and the reason for it. The user can still pick something else, but a naked question is less useful than a question with a proposal.

### 3. Prefer exploring the codebase over asking

If a question can be answered by reading files, running `grep`, or following existing patterns, do that instead of asking. Only ask the user for information the codebase cannot provide.

### 4. Ask one question at a time

Do not batch multiple questions in a single message. One question, one recommendation, wait for the answer, then move to the next branch.
