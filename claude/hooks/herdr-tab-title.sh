#!/bin/sh
# Names the herdr tab after the session title Claude Code generates for the terminal.
# Only replaces herdr's default numeric labels, so tabs you named by hand are kept.
# Runs on prompt submit, but the title is generated asynchronously after it, so it polls
# detached instead of blocking the prompt.
[ "${HERDR_ENV:-}" = "1" ] && [ -n "${HERDR_PANE_ID:-}" ] && [ -n "${HERDR_TAB_ID:-}" ] || exit 0

label=$(herdr tab get "$HERDR_TAB_ID" | jq -r '.result.tab.label // empty')
case "$label" in *[!0-9]*|'') exit 0 ;; esac

setsid sh -c '
  for _ in $(seq 60); do
    title=$(herdr agent get "$HERDR_PANE_ID" | jq -r ".result.agent.terminal_title_stripped // empty")
    case "$title" in ""|"Claude Code") sleep 2 ;; *) herdr tab rename "$HERDR_TAB_ID" "$title"; exit ;; esac
  done
' >/dev/null 2>&1 </dev/null &
