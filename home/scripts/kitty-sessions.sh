#!/usr/bin/env bash

dir="${KITTY_SESSIONS_DIR:-$HOME/Projects}"
CACHE_DIR="${KITTY_SESSIONS_CACHE:-$HOME/.cache/kitty-sessions}"
SOCKET="${KITTY_SESSIONS_SOCKET:-unix:@kitty-sessions}"
self=$(readlink -f "$0")

[[ ! -d $CACHE_DIR ]] && mkdir -p "$CACHE_DIR"

notify() { notify-send -u low "Kitty Sessionizer" "Session: $1"; }

# Write the session file for the project at $1 and open it: switch to its
# tabs if the sessionizer is already running, otherwise start one with it.
open_session() {
  local selected=$1 name file
  name=$(basename "$selected" | tr '.' '_')
  file="$CACHE_DIR/$name"

  # No new_os_window: every session is loaded as tabs into the single
  # sessionizer window. tab_bar_filter in kitty.conf hides tabs from other
  # sessions, so the window behaves like one session at a time.
  printf '%s\n' \
    'new_tab editor' \
    "cd $selected" \
    'launch nvim .' \
    '' \
    'new_tab terminal' \
    "cd $selected" \
    'launch bash' \
    >"$file"

  if kitten @ --to "$SOCKET" ls &>/dev/null; then
    # goto_session focuses the session's tabs if it is already open,
    # otherwise loads them into the existing window.
    kitten @ --to "$SOCKET" action goto_session "$file"
  else
    kitty --session "$file" --detach --listen-on "$SOCKET"
  fi
}

pick_and_open() {
  local name
  name=$(fd -t d . "$dir" --max-depth 1 --format '{/}' |
    fzf --reverse --margin=2 --prompt="session> ") || exit 0
  [[ -z $name ]] && exit 0
  open_session "$dir/$name" && notify "$name"
}

case "${1:-}" in
  --pick)
    # Runs inside the overlay window (or the first window of a fresh
    # instance). Exiting closes the overlay, revealing the picked session.
    pick_and_open
    ;;
  '')
    if kitten @ --to "$SOCKET" ls &>/dev/null; then
      # Overlays do not raise a backgrounded window, so focus it first.
      kitten @ --to "$SOCKET" focus-window --match recent:0 || true
      # Overlay the picker on the current window. It exits after switching
      # sessions, which closes the overlay.
      kitten @ --to "$SOCKET" launch --type=overlay --title "kitty-sessions" \
        --env "PATH=$PATH" bash "$self" --pick
    else
      # No sessionizer yet: start one with the picker as its first window.
      kitty --detach --listen-on "$SOCKET" bash "$self" --pick
    fi
    ;;
  *)
    selected="$dir/$1"
    mkdir -p "$selected"
    open_session "$selected" && notify "$1"
    ;;
esac
