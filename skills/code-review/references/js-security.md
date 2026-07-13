# JavaScript/TypeScript Security Rules

## Don't redact data that will be returned and acted on
Redaction replaces content with a placeholder (e.g. `<redacted>`). If that data is
sent to a system that returns a modified version of it (e.g. an AI asked to rewrite
a file), the placeholder will appear unchanged in the output. If you then write
that output to disk, you commit `<redacted>` as real content.

Only redact data that is consumed as context and never returned:
- Log lines, error messages, comment bodies, diff hunks
- Test output sent as retry context

Do NOT redact data that the system is expected to return in modified form:
- File contents sent to an AI that returns the full file back

## Apply sanitization at every exit point
When establishing a sanitization rule for data sent to an external API (e.g. secret
redaction, allowlist filtering), audit *all* paths where that data flows out, not
just the primary one. Secondary paths (retry loops, error handlers, fallback branches)
are easy to miss and will transmit raw data if overlooked.

When sanitizing one field in a data structure, check every sibling field in the same
structure before moving on. Partial sanitization of a single object is as dangerous
as none.

## Track success explicitly
When a follow-up action depends on a prior operation having succeeded, track success
explicitly rather than assuming it. Collecting results into a separate list (e.g.
`succeededIds`) and acting only on that list is safer than acting on the full input set.

```js
// Wrong: resolves all threads regardless of whether replies were posted
await resolveThreads(comments.map(c => c.id));

// Correct: only resolve threads that got a reply
const repliedIds = [];
for (const { comment_id, body } of replies) {
  try {
    await postReply(comment_id, body);
    repliedIds.push(comment_id);  // track success explicitly
  } catch (e) { ... }
}
await resolveThreads(repliedIds);
```

## Treat external API responses as untrusted input
Validate the shape of any response from an external API before destructuring or acting
on it. An unexpected shape (null entries, missing fields, wrong types) will throw during
destructuring and may abort the run before cleanup or marker-posting code executes.

```js
// Wrong: throws if commits is not an array or an entry is malformed
for (const { path, content } of commits) { ... }

// Correct: validate first, skip malformed entries gracefully
if (!Array.isArray(commits)) { core.warning('...'); return; }
for (const entry of commits) {
  if (!entry || typeof entry.path !== 'string' || typeof entry.content !== 'string') {
    core.warning(`Skipping malformed entry: ${JSON.stringify(entry)}`);
    continue;
  }
  const { path, content } = entry;
  ...
}
```

## Validate parsed inputs immediately
After parsing external inputs (e.g. `parseInt`, `parseFloat`, `JSON.parse`), validate
the result before using it. Letting `NaN`, `null`, or out-of-range values propagate into
downstream logic causes cryptic failures far from the source.

```js
const n = parseInt(input, 10);
if (!Number.isFinite(n)) {
  core.setFailed(`Invalid input '${input}': expected a number.`);
  return;
}
```

## Never use sed or awk to edit JS/TS files
Always use the Edit tool for JavaScript and TypeScript edits. `sed` and `awk` mangle
indentation (writing literal `\t` instead of tab characters), which breaks builds and
can silently land a change in the wrong function when the surrounding context looks similar.
The Edit tool shows exact before/after context, making it obvious whether the right
location was matched.

## Check guard flags inside async callbacks, not just before dispatch

When using a flag to short-circuit async work (e.g. `errorOccurred`, `cancelled`),
check it at every point where side effects occur — including inside `.then()` and
`.catch()` callbacks — not just before the async call is dispatched. By the time a
callback fires, the flag may already have been set by a concurrent operation.

```js
// Wrong: flag checked before dispatch, but the in-flight .then() still runs
if (!errorOccurred) {
  fetch(url).then(data => addMarker(data[0])); // can still fire after errorOccurred = true
}

// Correct: check the flag inside the callback too
fetch(url).then(data => {
  if (!errorOccurred) {
    addMarker(data[0]);
  }
});
```

## Use word boundaries in keyword regex patterns
When matching keywords in regex (e.g. `auth`, `token`, `key`), always use `\b` word
boundaries to avoid false positives on substrings. Without them, `auth` matches
`author`, `token` matches `tokenize`, etc.

```js
// Wrong: matches 'author:', 'authenticate', etc.
/auth\s*[=:]/i

// Correct
/\bauth\b\s*[=:]/i
```
