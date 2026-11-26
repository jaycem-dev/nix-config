#!/usr/bin/env bash

dir="${KITTY_SESSIONS_DIR:-$HOME/Projects}"
CACHE_DIR="${KITTY_SESSIONS_CACHE:-$HOME/.cache/kitty-sessions}"
SOCKET="${KITTY_SESSIONS_SOCKET:-unix:@sessions}"
self=$(readlink -f "$0")

mkdir -p "$CACHE_DIR"

notify_error() { notify-send -u normal "Kitty Sessionizer" "Failed to open session: $1"; }
running() { kitten @ --to "$SOCKET" ls &>/dev/null; }

open_session_file() {
  local file=$1
  if running; then
    # goto_session focuses the session's tabs if it is already open,
    # otherwise loads them into the existing window.
    kitten @ --to "$SOCKET" action goto_session "$file"
  else
    kitty --session "$file" --detach --listen-on "$SOCKET"
  fi
}

# Write the session file for the project at $1 and open it: switch to its
# tabs if the sessionizer is already running, otherwise start one with it.
open_session() {
  local name=${1##*/}
  local file="$CACHE_DIR/${name//./_}"

  mkdir -p "$1" || return 1

  # No new_os_window: every session is loaded as tabs into the single
  # sessionizer window. tab_bar_filter in kitty.conf hides tabs from other
  # sessions, so the window behaves like one session at a time.
  printf '%s\n' \
    'new_tab editor' \
    "cd $1" \
    'launch nvim .' \
    'new_tab terminal' \
    "cd $1" \
    'launch' \
    >"$file" || return 1

  open_session_file "$file"
}

open_home() {
  local file="$CACHE_DIR/home"

  printf '%s\n' \
    'cd ~' \
    'launch' \
    >"$file" || return 1

  open_session_file "$file"
}

pick_and_open() {
  local name session active active_session active_sessions
  if running; then
    active_sessions=$(kitten @ --to "$SOCKET" ls --match-tab 'session:.*' 2>/dev/null |
      jq -r '.. | objects | .session_name? // empty' | sort -u)
  fi
  name=$(while IFS= read -r session; do
    active=
    while IFS= read -r active_session; do
      [[ $active_session == "${session//./_}" ]] && { active=' 󰧞'; break; }
    done <<< "$active_sessions"
    printf '%s\t%s%s\n' "$session" "$session" "$active"
  done < <(fd -t d . "$dir" --max-depth 1 --format '{/}') |
    fzf --reverse --delimiter=$'\t' --with-nth=2 --accept-nth=1 --prompt="session> " \
      --bind 'enter:accept-or-print-query')
  [[ -z $name ]] && exit 0
  open_session "$dir/$name" || notify_error "$name"
}

case "${1:-}" in
  --pick)
    # Runs inside the overlay window (or the first window of a fresh
    # instance). Exiting closes the overlay, revealing the picked session.
    pick_and_open
    ;;
  --home)
    open_home || notify_error "home"
    ;;
  '')
    if running; then
      # Overlays do not raise a backgrounded window, so focus it first.
      kitten @ --to "$SOCKET" focus-window --match recent:0 || true
      # Overlay the picker on the current window. It exits after switching
      # sessions, which closes the overlay.
      kitten @ --to "$SOCKET" launch --type=overlay --title "kitty-sessions" \
        "$self" --pick
    else
      # No sessionizer yet: start one with the picker as its first window.
      kitty --detach --listen-on "$SOCKET" "$self" --pick
    fi
    ;;
  *)
    open_session "$dir/$1" || notify_error "$1"
    ;;
esac
