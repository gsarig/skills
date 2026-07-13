---
name: writing-skills
description: "Guides creation or update of a `SKILL.md`: chooses the right frontmatter fields (`description` vs `when_to_use`, `argument-hint`, `model`, `effort`, `allowed-tools`, `paths`, `disable-model-invocation`, etc.), runs two pressure tests, and follows the approval flow before writing."
when_to_use: "Use when asked to write, create, or update a skill (SKILL.md file). Follow all steps in order; do not shortcut based on this description."
effort: xhigh
---

## Steps

### 1. Clarify the trigger condition

Before writing anything, establish: in what situation should this skill activate? The answer must be a specific, observable event (something the user says or does), not a description of what the skill will accomplish. This becomes the `when_to_use` field, not `description`.

If the trigger is vague ("when it seems useful"), ask for a concrete example before proceeding.

### 2. Determine where the skill lives

| Scope | Location |
|-------|----------|
| Global (applies across all projects) | `~/.claude/skills/<name>/SKILL.md` |
| Project-specific | `.claude/skills/<name>/SKILL.md` in the project root |

Ask if not obvious from context.

### 3. Pick the frontmatter fields

Every skill uses `name`, `description`, and `when_to_use`. Go through the rest of the field list and include only what genuinely applies; omit the rest.

| Field | Include when |
|-------|-------------|
| `description` | Always. One sentence on what the skill produces or does; outcome-focused, not a walkthrough of the steps. |
| `when_to_use` | Always. Trigger phrases, example user requests, and the anti-shortcut suffix: `Follow all steps in order; do not shortcut based on this description.` |
| `argument-hint` | The skill accepts an argument (URL, file path, vault name). Format as `"[what it accepts]"`. |
| `model: sonnet` (or `haiku`) | The skill is a mechanical workflow that does not need the session model's full capability; pinning a cheaper model saves usage. Omit for high-judgment skills (review, interview, design) so they inherit the session model. Never pin a model to force quality upward: a pin caps the skill when the session runs a stronger tier (e.g. Fable). |
| `effort: high` | The skill requires high-judgment reasoning and benefits from deeper thinking. |
| `allowed-tools` | The skill runs repetitive commands that would otherwise prompt (e.g. `Bash(git *) Bash(gh *) Read`). Additive, not restrictive. |
| `paths` | The skill naturally scopes to specific files expressible as a glob (e.g. `**/*.config.json`). Auto-triggers the skill when editing those files. |
| `disable-model-invocation: true` | The skill has side effects that should require deliberate user invocation (posting to a live site, deploying, deleting). |
| `user-invocable: false` | The skill is pure background knowledge; the user never types `/skill-name`. |
| `license` | The skill is open-source or shareable. Common values: `MIT`, `Apache-2.0`. |
| `metadata` | Custom key-value pairs for distribution: `author`, `version`, `mcp-server`, `category`, `tags`, `documentation`, `support`. Useful when publishing publicly. |

### 4. Draft the skill

Use this structure. Omit any field that does not apply.

```markdown
---
name: <skill-name>
description: "<one-sentence outcome-focused summary>"
when_to_use: "<triggers + example phrasings + anti-shortcut suffix>"
argument-hint: "[...]"
model: sonnet
effort: high
allowed-tools: Bash(git *) Read
paths: "**/*.ext"
disable-model-invocation: true
---

## Steps

[The actual workflow. No summary at the top. Jump straight into the first step.]
```

**Optional companion folders.** A skill is a folder, not just a single file. When SKILL.md grows large or needs supporting assets, split content out:

```
<skill-name>/
├── SKILL.md            # required
├── scripts/            # optional — executable code (Python, Bash, etc.)
├── references/         # optional — detailed docs, loaded only when needed
└── assets/             # optional — templates, fonts, icons
```

Reference these from SKILL.md by path (e.g. `See references/api-patterns.md for rate limiting guidance`). Do **not** add a `README.md` inside the skill folder — all human-facing documentation belongs in SKILL.md or `references/`. A repo-level README is fine when distributing via GitHub; it just must not live inside the skill directory itself.

**Rules for `description`:**

- One sentence, outcome-focused.
- Good: "Reviews a PR and reports issues grouped by severity."
- Bad: "Gets the diff via gh, runs composer lint, writes numbered comments." (too implementation-specific; invites shortcut-following.)
- Never stuff trigger phrases into `description`; they belong in `when_to_use`.

**Rules for `when_to_use`:**

- Start with "Use when the user..." and list concrete triggers.
- Include the anti-shortcut suffix: `Follow all steps in order; do not shortcut based on this description.`
- `description` and `when_to_use` are concatenated in the skill listing and share a 1,536-character cap. Keep both tight.
- Add **negative triggers** when over-triggering is a real risk: `Do NOT use for [adjacent case] (use [other-skill] instead).` This is more effective than tightening the positive trigger phrasing alone.

**Rules for the body:**

- Do not open with a paragraph summarising what the skill does. Jump directly to Step 1.
- Steps should be imperative and specific. "Search for X before asking" is better than "You may want to consider searching for X."
- If parts of the workflow must be followed exactly (no adaptation), mark them explicitly: **This step is not optional.**
- For sections that must not be skipped, prefer a dedicated `## Important` or `## Critical` heading over inline bold. Headers are harder to skim past than emphasis inside a paragraph.

### 5. Pressure-test before finalising

Run two mental tests.

> If an agent read only `description` + `when_to_use`, what would it do?

The right answer is "decide whether this skill applies to the current task," not "attempt the task." If the metadata reads like a walkthrough, tighten the description.

> What would a lazy agent do if this skill did not exist?

Write down that failure mode. Check that the skill's steps directly prevent it. If not, add a step or a "What to avoid" section.

### 6. Present for approval

Show the full draft. Do not write the file until the user confirms.

### 7. Write the file

Once approved, write the SKILL.md to the chosen location:

- **Global skills:** `~/.claude/skills/<name>/SKILL.md`.
- **Project skills:** `<project-root>/.claude/skills/<name>/SKILL.md`.

The folder under `skills/` must be a top-level directory, not nested. Use the frontmatter `name:` value as the directory name (e.g. `skills/obsidian-charts/`, not `skills/obsidian/charts/`), because Claude Code only scans the top level.

---

## What to avoid

- **Mixing what-it-does and when-to-invoke in `description`.** `description` summarises the outcome; `when_to_use` carries the triggers.
- **Writing a walkthrough in `description`.** If it reads like step-by-step, compress to the outcome. Implementation details invite shortcut-following.
- **Opening the body with an explanation of the skill.** The first line of the body should be a step, not "This skill is designed to...".
- **Vague trigger conditions.** "Use when appropriate" is not a trigger. "Use when the user says X or does Y" is.
- **Skipping the pressure test.**
- **Bloating SKILL.md.** Keep it under ~5,000 words. Move detailed reference material (API patterns, error catalogs, large templates) into `references/<topic>.md` and link to it from the relevant step. Large SKILL.md files degrade response quality because all of it loads into context once the skill triggers.
