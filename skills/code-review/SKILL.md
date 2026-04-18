---
name: code-review
description: "Reviews a pull request, a local diff or patch file, or staged files; detects and runs the project's lint script, then reports issues grouped by severity (critical, medium, minor) with an optional unrelated-security-concerns section."
when_to_use: "Use when the user asks for a code review in any form: /code-review, 'code review this', 'CR this', or similar. Follow all steps in order; do not shortcut based on this description."
argument-hint: "[PR URL | path to diff file]"
model: opus
effort: high
allowed-tools: Bash(git *) Bash(gh *) Bash(composer *) Bash(npm *) Bash(make *) Read Grep
---

## Steps

### 1. Gather requirements

If the user has not provided specific requirements for the change being reviewed, ask:

> "Do you have specific requirements I should keep in mind? (e.g. a ticket description, acceptance criteria, or expected behaviour)"

Wait for the response before proceeding. If they decline, proceed without requirements.

### 2. Determine review mode

**If a PR URL was provided:** proceed to Step 3a.

**If a file path was provided** (`.diff`, `.patch`, `.txt`, or any file containing a diff): proceed to Step 3c.

**If no URL or file was provided:** run `git diff --cached --name-only` and show the list of staged files, then ask:

> "I can see the following staged files: [list]. Is this everything, or do you need to stage more before I proceed?"

Wait for confirmation before continuing.

### 3a. PR mode — fetch the diff

Extract the PR number from the URL. Run `gh pr view <number>` and `gh pr diff <number>`. Proceed to Step 4.

### 3b. Staged files mode — get the diff

Run `git diff --cached` to get the full diff of staged changes. Proceed to Step 4.

### 3c. Diff file mode — read the diff from a local file

Read the file at the provided path. If the file is too large to read in one pass, read it in chunks. Treat the contents as the diff. Proceed to Step 4.

### 4. Detect and run linter

Check only these three files in the project root — no directory traversal:

1. `composer.json` — if it has a `lint` script, run `composer lint`
2. `package.json` — if it has a `lint` script, run `npm run lint`
3. `Makefile` — if it has a `lint` target, run `make lint`

If a linter runs and fails, prepend a blocker at the top of the review:

> ⚠ **Linter failed** — must be fixed before merging.
> [relevant output]

If no linter is detected, note it briefly and proceed.

### 5. Review the changes

Review only lines introduced or modified in the diff. Do not flag pre-existing issues in unchanged lines unless they are security concerns.

Priorities in order:
1. **Security** — always flag, even if unrelated to the change (handled separately in Step 6)
2. **Correctness** — does it fulfil the requirements?
3. **Best practices**
4. **Reusability and extensibility**
5. **Simplicity** — flag overengineering, not just under-engineering

### 6. Format and present the review

**Severity levels:**

| Severity | Use when |
|---|---|
| **critical** | Security vulnerability, data loss/corruption, production breakage, or a change that will hard-fail the CI pipeline and block all deployments |
| **medium** | Correctness concern, functional issue, or CI regression that will surface during development or testing but won't block the entire pipeline |
| **minor** | Hygiene, consistency, cleanup, or style |

**Numbered comments:**

```
N) `path/to/file.php` L23 — **severity**
Short explanation.
Full explanation if needed. If multiple issues on the same line, use a dash list:
- Issue one
- Issue two
```

**Unrelated security concerns** — append after all numbered comments, separated by `---`:

```
---
⚠ Security concerns unrelated to these changes:

- `path/to/file.php` L45 — description
```

Omit this section entirely if there are no unrelated security concerns.
