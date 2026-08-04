---
name: writing-instructions
description: "Guides writing or revising a behavioral rule in the instruction files so it lands in the right scope, doesn't duplicate or contradict an existing rule, and stays lean."
when_to_use: "Use when the user invokes /writing-instructions, or asks to add, edit, refine, or relocate a behavioral rule in their instruction files (the global CLAUDE.md, a project CLAUDE.md, or a situational topic file). Also use after a retro or a correction surfaces a lesson worth making into a standing rule. Do NOT use for writing a SKILL.md (use writing-skills instead) or for project READMEs and docs. Follow all steps in order; do not shortcut based on this description."
argument-hint: "[the rule or lesson to capture]"
effort: xhigh
---

## Steps

### 1. First decide whether this should be a rule at all
Declining is a valid and common outcome of this skill; "write the rule" is not a foregone conclusion. Evaluate the proposal on merit and say so plainly if it should not be added. Reject or redirect when:
- There is no concrete, observable trigger and action. "Be more careful with Z" is a disposition, not a rule; you cannot tell whether it was followed. Sharpen it or drop it.
- It will not recur. One incident is not a pattern.
- It is already covered by an existing rule (see step 3). Extend that one, or do nothing.
- It contradicts an existing rule with no clear reason to supersede it.
- It is project-specific. Prefer a project CLAUDE.md over the global rules.

Only once it clears this gate, continue.

### 2. Choose the scope and file
Place by how often the rule is actually needed; a narrow rule in an always-loaded file is itself noise, paid every session.

| Scope | File |
| --- | --- |
| Applies in any session, any project | the global `~/.claude/CLAUDE.md` |
| Applies to one project only | that project's `CLAUDE.md` |
| Needed only in a specific context (a tool, a task type) | a situational topic file referenced from the global `CLAUDE.md` (e.g. `phpstan.md`, `playwright.md`); add a new file and reference row if none fits |

Test: needed every session, or only in a specific context? If the latter, it belongs in a situational file, not the global `CLAUDE.md`.

### 3. Dedupe, then extend
Search the target file and the adjacent ones for a rule that already covers this. If a partial one exists, extend it rather than adding a near-duplicate. Duplicates drift apart and contradict over time.

### 4. Check for contradictions
Confirm the new rule does not conflict with an existing one anywhere in the file set. If it does, resolve it explicitly (reword or supersede one) rather than leaving both to fight.

### 5. Write it tight
- Lead with the actionable core. Cut rationale that does not change behavior; keep only the "why" that tells future-you when the rule applies.
- One logical line per paragraph; no hard-wrapping.
- Give it a `###` heading that names the rule as an imperative.

### 6. Edit the source, then commit
Edit the real file, not a symlink to it: if `~/.claude/CLAUDE.md` (or the skills directory) is a symlink into a dotfiles repo, edit the copy in that repo. If the file is version-controlled, commit after saving. Do not push unless asked.

## What to avoid

- Vague rules with no observable trigger ("be careful", "try to remember").
- Putting context-specific guidance in the always-loaded global `CLAUDE.md`; that is the noise you are trying to avoid.
- Restating a rule that already exists in another file.
- Padding the rule with rationale that does not change behavior.
- Editing a symlink instead of the version-controlled source it points to.
