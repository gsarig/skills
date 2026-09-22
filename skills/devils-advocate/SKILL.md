---
name: devils-advocate
description: "Produces a one-shot devil's-advocate critique of a plan, design, or decision: steel-manned strengths first, then severity-tagged findings each with a concrete alternative, then a verdict."
when_to_use: "Use when the user asks to challenge, critique, stress-test, pressure-test, or poke holes in a plan, design, architecture decision, or proposal (e.g. 'play devil's advocate on this', 'what's wrong with this plan?', 'challenge this approach', 'review this design and push back'). Do NOT use for code, PR, or diff review (use the code-review skills). Do NOT use for interactive one-question-at-a-time interrogation (use grill-me). Follow all steps in order; do not shortcut based on this description."
argument-hint: "[optional pointer to what to critique]"
model: opus
effort: xhigh
---

## Steps

### 1. Identify the target

Critique what the argument names. With no argument, default to the most recent substantive proposal in the conversation: the suggestion, decision, or design just put forward. State the target in one line before going further, so a wrong pick is caught immediately rather than after a full critique. When several candidates are equally plausible, name the best guess and say what else it could have been.

### 2. Calibrate intensity to stakes

Before critiquing, judge how hard the decision is to reverse and how costly a wrong call would be. Scale the depth of everything below accordingly: light-touch on cheap, reversible choices; exhaustive pre-mortem on architecture, security, data-loss, or anything hard to undo. State the calibration level in one line at the top, naming the model this pass is running on, so the user knows both how heavy the critique is and which model produced it. The model pin is the point of this skill from a weaker session, and a pin that silently failed to apply is worse than none, because the critique still reads as authoritative.

### 3. Steel-man before you attack

**This step is not optional.** Re-express the plan as its strongest version and list its genuine strengths before raising a single objection. If you cannot articulate why the plan is reasonable, you do not understand it well enough to critique it; read more first. This guards against straw-manning and keeps the critique honest.

### 4. Audit the assumptions

Enumerate the assumptions the plan rests on, especially unstated ones. Classify each by likelihood-of-being-wrong and impact-if-wrong. Aim the critique at the high-impact, uncertain assumptions. Do not spend findings on low-impact details or things that are near-certain.

### 5. Stress-test with the toolkit

Apply, scaled to the calibration from step 2:
- **Pre-mortem:** assume the plan shipped and failed. Narrate why.
- **Inversion:** what would reliably *guarantee* failure here? Is the plan accidentally close to it?
- **Second-order effects:** what does this cause downstream, one and two steps out?
- **Overengineering/scope check:** does this solve more than what was asked? Would the smallest change that meets the need do the job instead? Flag unnecessary abstraction, new components, or scope creep the same as any other finding.

### 6. Report in this format

- **Strengths:** from the steel-man.
- **Findings:** each tagged **Critical / Major / Minor**, carrying: assumption challenged, failure scenario, impact, and a recommendation.
- **Verdict:** one line, one of: *Proceed*, *Proceed with revisions* (name them), *Do not proceed as scoped*.

**Core rule: no bare objection.** "This could fail" is not a finding. Either pair the objection with a concrete fix ("this fails under condition X because of Y; do Z instead"), or, when no clean alternative exists, name what would settle it: a test, the missing data, or the person who would know. Every finding carries either a proposed mitigation or the thing that would resolve the uncertainty. Never drop a legitimate concern just because you lack a ready fix.

## Important: what to avoid

- **Manufactured dissent.** If the plan is genuinely sound at its stakes level, say so and keep the findings list short or empty. Do not invent objections to look rigorous.
- **Contrarianism for its own sake, nihilism, straw-manning, reverse-confirmation-bias** (reflexively distrusting whatever is proposed), or critiquing the person rather than the plan.
- **Treating the verdict as authority.** This is input for the user to weigh, not a ruling to obey.

## Handoff

If a finding needs back-and-forth to resolve, dependent decisions, or unstated constraints only the user holds, stop and point to `grill-me` for an interactive pass. This skill is the one-shot batch critique; `grill-me` is the interview.
