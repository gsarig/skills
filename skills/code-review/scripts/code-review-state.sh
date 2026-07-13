#!/usr/bin/env bash
#
# code-review-state.sh - per-project state for the code-review orchestrator.
# Stores the last chosen review type per source ID in a JSON file under the
# project's .claude/ directory. Persistence is skipped when no project context.
#
# Subcommands:
#   resolve              Print the state file path, or nothing if no project.
#   get <file> <id>      Print the stored type for <id>, or nothing.
#   set <file> <id> <type>
#                        Merge {<id>: <type>} into <file>, creating if absent.

set -euo pipefail

cmd="${1:-}"

case "$cmd" in
  resolve)
    if root=$(git rev-parse --show-toplevel 2>/dev/null); then
      if [ -d "$root/.claude" ]; then
        echo "$root/.claude/code-review-state.json"
      fi
    fi
    ;;
  get)
    file="${2:-}"
    id="${3:-}"
    [ -n "$file" ] && [ -n "$id" ] || { echo "Usage: $0 get <file> <id>" >&2; exit 1; }
    [ -f "$file" ] || exit 0
    jq -r --arg k "$id" '.[$k] // ""' "$file"
    ;;
  set)
    file="${2:-}"
    id="${3:-}"
    val="${4:-}"
    [ -n "$file" ] && [ -n "$id" ] && [ -n "$val" ] || { echo "Usage: $0 set <file> <id> <type>" >&2; exit 1; }
    mkdir -p "$(dirname "$file")"
    tmp=$(mktemp)
    if [ -f "$file" ]; then
      jq --arg k "$id" --arg v "$val" '. + {($k): $v}' "$file" > "$tmp"
    else
      jq -n --arg k "$id" --arg v "$val" '{($k): $v}' > "$tmp"
    fi
    mv "$tmp" "$file"
    ;;
  *)
    echo "Usage: $0 {resolve|get|set} ..." >&2
    exit 1
    ;;
esac
