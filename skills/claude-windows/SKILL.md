---
name: claude-windows
description: "Computes the optimal Claude usage-window ping schedule from work hours and creates or reconciles the scheduled cloud routines that pin the window boundaries."
when_to_use: "Use when the user invokes /claude-windows, asks to set up, recompute, or update their Claude usage-window pings/routines, or reports changed work hours and wants the ping schedule re-registered. Do NOT trigger just because work hours, usage limits, or the 5-hour window come up in conversation; only on an explicit request to (re)build the schedule. Follow all steps in order; do not shortcut based on this description."
argument-hint: "[HH:MM-HH:MM] [alpha 0-1]"
model: sonnet
---

## Steps

### 1. Resolve inputs

Parse the arguments for work hours (`HH:MM-HH:MM`) and optionally alpha (a number in (0,1)). For anything not supplied, fall back to the session environment, which the active profile's `settings.json` `env` block injects (so values are per profile, and each profile is a separate account):

- `CLAUDE_WINDOWS_HOURS` (e.g. `11:00-19:00`)
- `CLAUDE_WINDOWS_ALPHA` (default `0.5`; share of slack given to the morning window, higher = more morning)
- `CLAUDE_WINDOWS_DAYS` (default `1-5`; cron day-of-week field for the routines)

If neither args nor env provide hours, ask for them. If args were passed and differ from the stored env value, treat the args as the new default; Step 5 persists them.

### 2. Compute the schedule

All arithmetic in minutes. `W = 300` (the 5-hour window).

```
L     = end - start                       # workday length; must be > 0
k     = largest integer with (k-1)*W < L  # boundaries that fit strictly inside the day
slack = L - (k-1)*W                       # split budget between first and last window
b     = start + alpha*slack               # first boundary
boundaries = b, b+W, b+2W, ... while strictly < end   (exactly k of them)
sessions   = k + 1
```

Ping times:
- **Anchor** at `b - W` (starts the first window so it ends at `b`).
- **Insurance** at each boundary + 2 minutes (starts the next window even if the user is idle at the boundary).

Worked example for 11:00-19:00, alpha 0.5: L=480, k=2, slack=180, b=12:30; anchor 07:30, insurance 12:32 and 17:32; sessions 3 with usable splits 1.5h / 5h / 1.5h. Use this to sanity-check the arithmetic.

Edge cases: if `b - W` lands before 00:00, the anchor belongs to the previous calendar day; shift its cron day-of-week field back one day and say so in the report. If alpha is 0 or 1 the first or last window has no usable slice; warn and suggest a value.

### 3. Present the plan and wait for approval

Show: the window table (each window's span and usable slice), the ping times, and the exact routine changes (create/delete, with names and cron expressions). Then stop and wait for explicit approval.

**This step is not optional.** Never create, update, or delete a routine before the user approves the plan.

### 4. Reconcile the cloud routines

These must be **cloud routines** created via the schedule mechanism (`/schedule`), never local cron jobs; local jobs die with the machine.

1. List existing routines. Ours are the ones whose names start with `claude-windows-`.
2. Reconcile stale `claude-windows-*` routines by updating them in place; the routines API cannot delete, so if the new plan needs fewer routines than exist, point the user to https://claude.ai/code/routines to remove the extras. Never touch a routine without that prefix.
3. Create the planned ones, named `claude-windows-anchor`, `claude-windows-boundary-1`, `claude-windows-boundary-2`, ...:
   - cron: `M H * * <days>` from the computed times and config. Cron runs in UTC: convert the local times, and warn in the report that a DST change in the user's timezone shifts the local firing times by an hour until the skill is re-run.
   - model: Haiku (cheapest; the reply is throwaway)
   - prompt: `Reply with the single word: ok. Do nothing else.`

### 5. Persist config and report

If hours or alpha came from args and differ from the stored env values, persist them to the active profile's settings file at `$CLAUDE_CONFIG_DIR/settings.json` (default `~/.claude/settings.json` when the variable is unset): Read the full file first, then edit ONLY the relevant keys inside the `env` block (creating the block if absent), preserving everything else byte for byte. This is a live harness file; the permission prompt on the edit is expected. If the user declines the edit, proceed without persisting and tell them which key to set manually. Note that env changes load at session start, so a bare `/claude-windows` picks up the new default from the next session onward.

Report: routines created/deleted, the session count, whether the default was persisted, and two standing caveats in one line each: the weekly cap is unaffected, and a message sent before the anchor ping shifts that day's boundaries (self-heals if sent more than 5h before the anchor).

## Critical

- Only routines prefixed `claude-windows-` may ever be deleted or replaced.
- No routine changes before the Step 3 approval.
- Cloud routines only; never `CronCreate`/local cron for this.
