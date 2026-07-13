---
name: investigate
description: "Investigates a question to a grounded conclusion in which every claim is either verified against a primary source or explicitly flagged as an untested hypothesis."
when_to_use: "Use when the user invokes /investigate, or asks you to get to the bottom of something, find a root cause, determine whether a reported issue is real, or verify a claim before acting on it (e.g. 'investigate X', 'why is X happening?', 'is this actually a bug?', 'are you sure?'). Do NOT use for a trivial single-fact lookup whose source is already known and unambiguous. Follow all steps in order; do not shortcut based on this description."
argument-hint: "[what to investigate]"
---

## Steps

### 1. State the question and what would answer it

Write one line: exactly what you are trying to determine, and what a confident answer looks like (a specific observation, value, or reproduction). This is the target every later step is measured against. If the question is ambiguous, ask one focused clarifying question and wait; do not guess the intent and investigate the wrong thing.

### 2. Get the latest context from the source, not a copy

Do not reason from stale local files, cached ticket text, prior summaries, or memory. Re-fetch each input at its origin: pull the live ticket/PR, checkout or read the current code, look at the actual data. List the sources you will trust and mark which you have versus still need. **This step is not optional** when anything could have changed since you last saw it.

### 3. Ground every claim in a primary source, never a proxy

A claim is only as good as what it rests on. Read the actual code, not a comment describing it. Read the actual ticket thread, not a one-line summary of it. Check the actual data, not an assumption about its shape. Comments, docstrings, ticket summaries, and variable names are leads that tell you where to look, not evidence you can cite.

### 4. Reproduce runtime claims before stating them

If a claim is about what happens when the system runs (it 404s, it breaks, it redirects, it regresses, it returns X), observe it happening: run the command, curl the endpoint, drive the page with Playwright, or write a test. Do not infer runtime behaviour from reading static code, config, or data files alone. Static inspection generates the hypothesis; execution confirms it.

### 5. Before declaring a check impossible, list your tools

"I can't verify this because X" is usually premature. Enumerate what you actually have (Playwright MCP, curl, git history, the dataset, a test harness, an MCP server) and try one before concluding a thing cannot be checked. An auth wall, a missing file, or an unfamiliar system is a reason to find the right tool, not to give up and guess.

### 6. When a check is beyond your reach, hand it over precisely

If a step genuinely requires something you cannot do (the user runs the query, holds the credentials, or has context only they have), stop and give the user the exact query, command, or thing to observe, plus what result would settle the question. Do not guess it or quietly drop it. This is distinct from Step 5: that is for tools you have; this is for checks that are legitimately someone else's to run.

### 7. Tag each claim: verified or inferred

For every factual statement in your conclusion, mark it. Verified: say how (which file and line, which command, what you observed). Inferred: call it a hypothesis and state the single thing that would confirm or refute it. Confidence must track evidence, never present a plausible guess in the same voice as a checked fact.

### 8. If your conclusion changes, name the evidence that flipped it

When new information reverses an earlier claim, say so explicitly and state the fact that changed your mind. Do not silently swap conclusions; a reader who saw the first answer needs to know why it moved.

### 9. Report briefly

Lead with the answer in one or two sentences. Then give only the evidence that supports it. Cut restated context, alternatives you did not take, and hedging padding. If the reply runs long, the length must be load-bearing, not decoration.

## What to avoid

- **Asserting a runtime effect from static code.** The most common failure: reading a data file or function and declaring what it "will" do at run time without running it. Reproduce first (Step 4).
- **Trusting a proxy over the source.** A code comment, a ticket summary, or a tidy explanation that contradicts the actual code or live behaviour is wrong until the primary source confirms it (Step 3).
- **Declaring impossibility without checking tools.** "Can't be verified" when a loaded tool would have done it (Step 5).
- **Guessing at a check that is someone else's to run** instead of handing it over precisely (Step 6).
- **Confidence that outruns evidence.** Stating inferences as facts (Step 7).
- **Verbosity.** A correct answer buried in three paragraphs of restatement wastes the reader (Step 9).
