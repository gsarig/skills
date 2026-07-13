# Shared review mechanics

Common steps and formatting rules used by every `code-review-*` skill. Type-specific guidance lives in each skill file. This doc holds only the invariants: source detection, diff fetching, verdict and severity format, common rules. Do not add `if type == X` branches here. If something is type-specific, it belongs in the skill file, not this doc.

---

## Source detection

1. If the user supplied a PR URL: **PR mode**. Extract the PR number. Skip to fetching.
2. If the user supplied a file path (`.diff`, `.patch`, `.txt`, or any file containing a diff): **file mode**. Skip to fetching.
3. If the invocation passed `--source=pr|file|branch|uncommitted|both` with the corresponding identifier args (`--pr=<URL>` or `--file=<path>` when relevant), use that mode directly. Skip to fetching.
4. Otherwise run both:

```
git status --short
git log --oneline main..HEAD
```

If both are empty, stop and tell the user there is nothing to review. If exactly one of the two is empty, auto-pick the non-empty one. If both are populated, ask:

> "Here's what I found:
> - Uncommitted changes (staged + unstaged): [list, or "none"]
> - Commits ahead of main: [N commits, or "none"]
>
> Review the uncommitted changes, the branch diff against main, or both?"

Wait for the answer. Map to **uncommitted**, **branch**, or **both**.

---

## Diff fetching

| Mode | Diff content | Changed file paths |
|---|---|---|
| PR | `gh pr view <N> --json title,body` and `gh pr diff <N>` | `gh pr diff <N> --name-only` |
| Uncommitted | `git diff HEAD` | `git diff HEAD --name-only` |
| Branch | `git diff main...HEAD` | `git diff main...HEAD --name-only` |
| Both | Uncommitted + branch, concatenated | Uncommitted + branch names, concatenated |
| File | Read the file at the provided path (chunk if large) | Parse `+++ b/<path>` lines from the diff content |

---

## Common review rules

- Review only lines introduced or modified in the diff. Do not flag pre-existing issues in unchanged lines unless they are security concerns.
- Before flagging a stylistic or best-practice issue in new code, check whether the same pattern is already established elsewhere in the codebase. If it is, surface it in the project-wide observations section rather than as a fix request for this PR. Security issues are exempt and get flagged regardless of consistency.
- **Never run tests.** Linting is the only automated check in a code review. CI runs tests on the PR. Never run `npm test`, `vitest`, `phpunit`, `jest`, or any test command during a code review.
- **Never run auto-fixers** (`composer lint-fix`, `phpcbf`, `prettier --write`, `eslint --fix`, `stylelint --fix`, or any wrapper). Report errors only.
- When referencing a line number in output, verify it against the actual source file with `grep -n`. Do not use the `+N` offset from a diff hunk header (`@@ -old,n +new,n @@`); that's the start of the context block, not the changed line.
- **Verify claims that reach beyond the diff before writing them.** Findings whose truth is visible in the diff itself (style, hygiene, an obvious typo) need no extra verification. Any finding that asserts something about the wider codebase, especially claims about callers, usages, or "all/never/unused", requires reading the surrounding code or grepping the call sites first; never assert it from the diff alone.
- **Severity needs a concrete failure scenario**: what input or state makes it break. If you cannot name one, downgrade the severity or phrase the finding as a question. If something material cannot be verified, report it as a question or an explicitly unverified concern; never state it confidently, and never drop it just because it is unverified.

---

## Linter detection (when a skill says to run it)

Check only these three files in the project root. No directory traversal.

1. `composer.json` with a `lint` script: `composer lint <changed-files>`
2. `package.json` with a `lint` script: `npm run lint -- <changed-files>`
3. `Makefile` with a `lint` target: `make lint` (no file scoping)

If `composer lint` or `npm run lint` exits with an argument or usage error (rather than actual lint errors), re-run without file arguments and note that linting ran project-wide.

If a linter runs and fails, count total errors and affected files, then prepend a single blocker line at the very top of the final review:

> ⚠ **Linter failed**: N error(s) across N file(s). Fix before merging.

Do not include the linter output. Do not analyse or propose fixes for individual lint errors. Lint failure forces a 🔴 **Request changes** verdict regardless of what the review finds.

If no manifest with a relevant lint script is detected, note it briefly and proceed.

---

## GitHub Actions hash verification (when a skill says to run it)

For every line matching `uses: {owner}/{repo}@{hash}` where `{hash}` is a 40-character hex string, verify the hash resolves to the version cited in the inline comment (if any):

```bash
gh api repos/{owner}/{repo}/tags --paginate \
  --jq '.[] | select(.commit.sha == "{hash}") | .name'
```

- Tag matches the comment: no issue.
- Tag doesn't match the comment: flag as **minor**, include the correct tag name.
- Command returns no tag: flag as **medium**: the hash points to an untagged commit.
- No inline comment: flag as **minor**: add a version comment for human readability.

---

## Output format

**Verdict line, always at the very top:**

| Verdict | Icon | When |
|---|---|---|
| Approved | ✅ | No critical or medium issues (minor issues are fine) |
| Request changes | 🔴 | One or more critical or medium issues, or linter failed |
| Comment | 💬 | Cannot determine mergeability (missing requirements, WIP, etc.) |

Format as a single bold line, before any other content:

```
✅ **Approved**. Only minor comments below.
```
```
🔴 **Request changes**: N critical / N medium issue(s) must be resolved before merging.
```
```
💬 **Comment**: [brief reason why a verdict cannot be given].
```

**Severity levels:**

| Severity | Use when |
|---|---|
| **critical** | Security vulnerability, data loss or corruption, production breakage, or a change that will hard-fail CI and block all deployments |
| **medium** | Correctness concern, functional issue, or CI regression that surfaces during development or testing but doesn't block the entire pipeline |
| **minor** | Hygiene, consistency, cleanup, or style |

**Numbered comments:**

```
N) `path/to/file.php` L23: **severity**
Short explanation.
Full explanation if needed. If multiple issues on the same line, use a dash list:
- Issue one
- Issue two
```

**Length and tone of comments.** Each finding is location, problem, fix, and the *why* only when the fix isn't self-evident from the problem statement. Aim for two to four sentences per finding; expand only when a security or architectural finding genuinely needs the rationale. Drop the following from comment bodies:

- Restating what the changed line does ("This adds a filter that ..."); the reviewer reads the diff.
- Hedging without substance ("you might want to consider", "perhaps", "it seems like"). If uncertain, ask a question; if confident, state the issue.
- Pleasantries ("nice work", "looks good overall but"). Say it once at the verdict line if at all, never per finding.
- Narrating your own review process ("I checked X, then verified Y, and found ..."). Report the conclusion.

Keep: exact file paths, exact line numbers, exact identifiers in backticks, concrete fix language, and the *why* when a reader cannot derive it from the diff or surrounding code.

**Unrelated security concerns**, appended after numbered comments and separated by `---`:

```
---
⚠ Security concerns unrelated to these changes:

- `path/to/file.php` L45: description
```

Omit this section entirely if there are no unrelated security concerns.

**Project-wide observations**, appended after the security block, separated by `---`:

```
---
ℹ Project-wide observations (out of scope for this PR):

- description of the pattern and why it may be worth revisiting across the codebase
```

Omit this section entirely if there are no such observations.
