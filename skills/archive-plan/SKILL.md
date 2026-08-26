---
name: archive-plan
description: "Retires a finished plan document: establishes from artifacts what actually shipped, files it under plans/archive/ with that record, and decides whether its procedure is worth generalising."
when_to_use: "Use when the user asks to archive, retire or file a plan that is finished: 'archive this plan', 'retire the security-hardening plan', 'this plan is done, file it away', '/archive-plan <path>'. Do NOT use to write or revise a plan (that is plan mode), on a plan still being worked, or to build a script or skill out of a procedure. Follow all steps in order; do not shortcut based on this description."
argument-hint: "[path to the plan, or its name]"
effort: high
disable-model-invocation: true
---

## Critical: never trust the plan's own status line

A finished plan almost always still claims to be a draft. Nobody goes back to edit the header on the way out. In the repo this skill was written for, four of five plans said "Not implemented" or "draft" while their deliverables were demonstrably live.

The status line is therefore the thing being **corrected**, never the thing being read to decide. Establish what shipped from artifacts, and treat the header as unverified prose until you have.

The corollary matters just as much: **do not replace a stale claim with a fresh unverified one.** A confident "shipped, 2026-08-25" written after checking two of six deliverables is the same failure with a newer date. Step 2 exists to make that impossible.

## Steps

### 1. Find the plan and read it

If an argument was given, resolve it. If not, search in this order and stop at the first directory that holds a plan-shaped document: `plans/` (excluding `archive/`), then `tmp/`, `docs/`, then the project root. Match `*plan*.md` first, then any Markdown file whose opening lines read as a plan.

A document merely *titled* as a plan is not automatically a candidate. `docs/` in particular tends to hold design write-ups whose heading says "implementation plan" but which are kept as standing reference, to be read rather than retired. The test is whether anyone is still meant to act on it.

Name the file you settled on and confirm it is the right one before going further. If several match, list them and ask.

Read it in full. List every deliverable it names: files it said it would create, configuration it said it would apply, decisions it said it would record, records it said it would update.

### 2. Establish what actually shipped

**This step is not optional and cannot be sampled.** Build one row per deliverable from step 1, and check each against a real artifact:

| Deliverable | Artifact checked | Result |
|---|---|---|
| A script the plan said it would add | file present at the stated path, and wired into its caller | present |
| A dependency the plan said it would remove | no match in any manifest, lockfile or config | present |
| A setting the plan said it would switch on in production | no evidence found either way | **could not verify** |

Rules for the table:

- **Every deliverable gets a row.** A plan with six work sections gets at least six rows, not two.
- **Result is one of `present`, `absent`, or `could not verify`.** The last is a real answer and must be recorded, never rounded up to `present`.
- **The Artifact checked column names what you actually looked at.** "Seems done" is not an artifact.
- **A blanket "shipped" is forbidden unless every row says `present`.** If any row does not, the plan is partial and must be reported as partial, naming the specific rows.

Then classify the plan's state:

- **Shipped**: every row `present`. Continue to step 3.
- **Partially shipped**: some rows `absent` or `could not verify`. Report exactly which, and ask whether to archive it as partial (recording the gaps) or leave it live. Do not decide this alone.
- **Abandoned or superseded**: it will not ship, because the approach was dropped or a later plan replaced it. Confirm this with the user rather than inferring it from absent artifacts, then continue to step 3.
- **Nothing shipped and still intended**: the plan is live. Say so and stop. Do not archive it.

### 3. Triage to a disposition

Exactly one:

| Disposition | Test |
|---|---|
| **Archive only** | The work does not repeat. It changed one system once. |
| **Generalised already** | The reusable form shipped as something executable: provisioning code, a template, a script, a skill. Find it and record where. |
| **Abandoned or superseded** | It will not ship. Record why, and point at whatever replaced it if anything did. |
| **Warrants a playbook** | It repeats on a *new target*, and the repeating part is judgement rather than commands. |

The discriminator between "generalised already" and "warrants a playbook" is the one that matters: **if the repeatable part is commands, it wants a script or a skill, not a playbook.** A playbook is for a procedure whose value is its decisions and its traps, which no script can carry.

A plan that never ran cannot warrant a playbook. Everything that makes a playbook worth having comes from what went wrong in execution, so abstracting an unexecuted draft yields only the plan with its specifics deleted.

### 4. Propose, and stop

**This step is not optional.** Present, and wait for approval:

- the evidence table from step 2, in full, including any `could not verify` rows
- the plan's state and the disposition, with the reasoning
- the exact file moves and reference edits that will follow

Move nothing before the user answers.

### 5. Archive (on approval)

In this order:

1. Create `plans/` and `plans/archive/` in the project if absent. Do not create `plans/playbooks/` unless step 6 runs.
2. Move the plan with `git mv`, or plain `mv` outside a repository. **Confirm it landed before going further:** the file is readable at its new path, and nothing remains at the old one. If either check fails, stop here. Repointing references at a file that never moved is worse than not having started.
3. **Rewrite the status line** to what step 2 established: that it shipped (or was abandoned or superseded), when, and the evidence. Carry any `could not verify` rows into the header as stated gaps. This correction is the point of the skill.
4. **Record the disposition**, with a pointer to where the reusable knowledge lives when there is one, so a later reader is not left guessing.
5. **Update references**, in two passes with different levels of care:
   - **Full path** (`plans/foo-plan.md`, `tmp/foo-plan.md`): distinctive enough to repoint mechanically. Grep and fix.
   - **Basename**: safe only when the name is plan-specific (`replace-gravity-forms-plan`). When the basename is generic (`plan`, `notes`, `todo`), **do not bulk-replace it**; a project-wide substitution of a token like `plan` will corrupt unrelated prose. Present the hits individually and confirm each.
   - **Wiki-style `[[links]]` resolve by basename**, so a move within the same vault does not break them. Leave them alone.
6. Verify the outcome, not the mechanism: the file still reads at its new path, nothing sits at the old one, and a grep of the full old path returns zero hits, or you state what remains and why. **The grep alone proves nothing about the move**, because 5.5 just rewrote those same strings; it would come back clean over an archive that does not exist. The two file checks are what confirm it does.
7. **Say what this could not check.** The grep covers this project only. If the plan may be referenced from a sibling repository or vault, name that limit rather than implying the sweep was complete, and ask the user whether any sibling references it.

### 6. Write the playbook (separate approval)

Only when step 3 said so, and only after asking again. This is the expensive half and deserves its own decision.

First, find the traps, because they are the reason a playbook beats a rewritten plan. In order of preference: an `## Execution log` section in the plan; the session transcript from the run; the project or per-target notes updated during it; the commit messages from that period. **Most plans have no execution log**, so expect to reconstruct. If none of these sources exist and nobody remembers the run, say so before writing: the playbook will be a stripped plan with no hard-won content, and that is worth knowing before spending the effort.

Write to `plans/playbooks/<name>-playbook.md`, where `<name>` derives from the source filename by **replacing** a trailing `-plan` rather than appending to it (`replace-gravity-forms-plan.md` becomes `replace-gravity-forms-playbook.md`). With no `-plan` suffix to replace, append `-playbook`.

- **Keep the whole plan.** Every step, the reasoning, the rejected alternatives. Abstracting is not summarising.
- **Turn specifics into parameters.** Names, ids, counts, versions and dates become `<placeholders>`, or become something the executor determines at run time.
- **Split the traps.** Conditional ones as "if the target has XX, then YY"; invariants stated flat, because a universal trap phrased conditionally invites the reader to decide it does not apply.
- **Put each trap at the step where it would be hit**, not in a section at the end. A playbook is read step by step during execution, and a trap collected at the bottom is read after you have already tripped it.
- Open with a status line marking it generic and naming the run it came from.

Then add a line to the archived original pointing forward to it.

## What to avoid

- Reading the plan's status line and believing it.
- Writing a fresh status line that is confident beyond the evidence table.
- Sampling deliverables instead of checking all of them.
- Archiving on your own judgement. Step 4 stops for a human every time.
- Bulk-replacing a generic basename across a project.
- Moving the file and stopping, leaving stale references behind.
- Declaring the archive done on the strength of a grep, without confirming the file is readable where you put it.
- Generating a playbook because the plan was long. Length is not repeatability.
- Abstracting a plan that never ran.
