# code-review

A family of Claude Code skills for reviewing pull requests, local diffs, patch files, and branch or uncommitted changes. This folder holds the orchestrator; four sibling folders hold the specialized review skills it dispatches to.

## How it works

`/code-review` triages the change (line count, file types, security-sensitive paths) and recommends one of four review types, then dispatches to the matching child skill:

| Child skill | Used for |
|---|---|
| [code-review-lite](../code-review-lite/) | Small, low-stakes code diffs (under ~500 lines, no security paths) |
| [code-review-deep](../code-review-deep/) | Large diffs (500+ lines) or anything touching auth, crypto, SQL, migrations, secrets |
| [code-review-infra](../code-review-infra/) | GitHub Actions, Terraform, Dockerfiles, docker-compose, IaC |
| [code-review-content](../code-review-content/) | Prose: markdown, docs, blog posts |

Your choice is remembered per source in the project's `.claude/code-review-state.json`, so re-reviewing the same PR or branch skips the prompt. You can also invoke a child skill directly when you already know the depth you want.

Every review opens with a verdict line (✅ Approved / 🔴 Request changes / 💬 Comment) followed by numbered findings with severities (critical, medium, minor), plus separate sections for unrelated security concerns and project-wide observations. Shared mechanics (source detection, diff fetching, linter detection, output format) live in `references/review-shared.md`; general review principles live in `references/review-checklist.md` (grow it with your own lessons), and JS/TS-specific rules in `references/js-security.md`.

## Installation

The family installs as five folders. From the repo root:

```bash
cp -r skills/code-review skills/code-review-lite skills/code-review-deep \
      skills/code-review-infra skills/code-review-content ~/.claude/skills/
```

The child skills reference the shared files at `~/.claude/skills/code-review/references/`, so install the whole set.

## Usage

- `/code-review` reviews uncommitted changes and/or the branch diff against main
- `/code-review <PR URL>` reviews a pull request
- `/code-review <path/to/file.diff>` reviews a local diff or patch file
- `/code-review --type=code-deep` skips the triage prompt
- `/code-review --lint` forces the linter to run in PR mode (it is skipped there by default because CI runs it)
- Or just say "code review this" / "CR this" in a Claude Code session

## Requirements

- The `gh` CLI, installed and authenticated, for PR reviews and GitHub Actions hash verification.
- `jq`, for remembering the chosen review type per source (optional; without it, skip the state script).
