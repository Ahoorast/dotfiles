#!/bin/sh
# Names the herdr tab after the session title Claude Code generates for the terminal.
# Only replaces herdr's default numeric labels, so tabs you named by hand are kept.
[ "${HERDR_ENV:-}" = "1" ] && [ -n "${HERDR_PANE_ID:-}" ] && [ -n "${HERDR_TAB_ID:-}" ] || exit 0

title=$(herdr agent get "$HERDR_PANE_ID" | jq -r '.result.agent.terminal_title_stripped // empty')
label=$(herdr tab get "$HERDR_TAB_ID" | jq -r '.result.tab.label // empty')

case "$title" in ''|'Claude Code') exit 0 ;; esac
case "$label" in *[!0-9]*|'') exit 0 ;; esac

herdr tab rename "$HERDR_TAB_ID" "$title" >/dev/null
