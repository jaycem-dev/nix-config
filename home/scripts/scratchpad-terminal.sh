#!/usr/bin/env bash
APP_ID="scratchpad"

# If a scratchpad terminal already exists, toggle show/hide it.
if niri msg --json windows | jq -e --arg id "$APP_ID" 'any(.[]; .app_id == $id)' >/dev/null; then
  nirius scratchpad-show --app-id "$APP_ID"
  exit
fi

# Otherwise spawn kitty with the scratchpad app-id.
niri msg action spawn -- kitty -1 --app-id "$APP_ID"

# Wait for the window to appear (up to ~5s) before marking it.
for _ in $(seq 1 50); do
  if niri msg --json windows | jq -e --arg id "$APP_ID" 'any(.[]; .app_id == $id)' >/dev/null; then
    break
  fi
  sleep 0.1
done

# Mark as scratchpad without moving it, so it stays visible on first open.
# Future Mod+Z presses hit the early-return above and toggle show/hide.
nirius scratchpad-toggle --app-id "$APP_ID" --no-move
