#!/usr/bin/env bash

dir=$(realpath -m "${KITTY_SESSIONS_DIR:-$HOME/Projects}")
extra_dirs=("$HOME" "$HOME/Pictures" "$HOME/Documents" "$HOME/Music" "$HOME/Videos")
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

# Write the session file for the directory at $1 and open it: switch to its
# tabs if the sessionizer is already running, otherwise start one with it.
open_session() {
  local name=${1##*/}
  local file="$CACHE_DIR/${name//./_}"
  local content

  mkdir -p "$1" || return 1

  # No new_os_window: every session is loaded as tabs into the single
  # sessionizer window. tab_bar_filter in kitty.conf hides tabs from other
  # sessions, so the window behaves like one session at a time.
  # TODO: look for a better way to check for existing session file, 
  # maybe a delete bind on fzf instead and only check if file exists here
  content=$(printf '%s\n' \
    'new_tab terminal' \
    "cd $1" \
    'launch')
  if [[ ! -f $file ]] || [[ $(<"$file") != "$content" ]]; then
    printf '%s\n' "$content" >"$file" || return 1
  fi

  open_session_file "$file"
}

open_app() {
  local app=$1
  shift

  if ! running; then
    open_session "$HOME" || return 1
    # wait for kitty to spawn before trying to use socket
    for _ in {1..50}; do
      running && break
      sleep 0.1
    done
  fi

  kitten @ --to "$SOCKET" focus-window --match recent:0 || true
  kitten @ --to "$SOCKET" launch --type=tab --cwd=current --tab-title "$app" \
    --focus-existing=@title --add-to-session=. "$app" "$@"
}

pick_and_open() {
  local selection path session active_session active_sessions label
  local -a paths active_rows=() inactive_rows=()
  local -A active=() known=()
  active_sessions=$(kitten @ --to "$SOCKET" ls --match-tab 'session:.*' 2>/dev/null |
    jq -r '.. | objects | .session_name? // empty')
  while IFS= read -r active_session; do
    [[ -n $active_session ]] && active["$active_session"]=1
  done <<< "$active_sessions"

  mapfile -t paths < <(
    fd -t d . "$dir" --max-depth 1 --format '{}'
    printf '%s\n' "${extra_dirs[@]}"
  )
  for path in "${paths[@]}"; do
    session=${path##*/}
    session=${session//./_}
    known["$session"]=1
    label=${path##*/}
    [[ $path == "$HOME" ]] && label='~'
    if [[ ${active[$session]+yes} ]]; then
      active_rows+=("$path"$'\t'"$label  󰧞")
    else
      inactive_rows+=("$path"$'\t'"$label")
    fi
  done
  while IFS= read -r active_session; do
    [[ -z $active_session || ${known[$active_session]+yes} ]] && continue
    known["$active_session"]=1
    active_rows+=("@session:$active_session"$'\t'"$active_session  󰧞")
  done <<< "$active_sessions"

  selection=$({
    ((${#active_rows[@]})) && printf '%s\n' "${active_rows[@]}"
    ((${#inactive_rows[@]})) && printf '%s\n' "${inactive_rows[@]}"
    true
  } |
    fzf --reverse --no-sort --delimiter=$'\t' --with-nth=2 --accept-nth=1 --prompt="session> " \
      --bind 'enter:accept-or-print-query')
  [[ -z $selection ]] && exit 0
  if [[ $selection == @session:* ]]; then
    open_session_file "$CACHE_DIR/${selection#@session:}" || notify_error "${selection#@session:}"
    return
  fi
  if [[ $selection != /* ]]; then
    selection="$dir/$selection"
  fi
  open_session "$selection" || notify_error "${selection##*/}"
}

case "${1:-}" in
  --home)
    open_session "$HOME" || notify_error "home"
    ;;
  --app)
    shift
    if [[ -z ${1:-} ]]; then
      notify_error "missing app"
      exit 1
    fi
    app=$1
    open_app "$@" || notify_error "$app"
    ;;
  '')
    if [[ -n ${KITTY_WINDOW_ID:-} ]]; then
      pick_and_open
    elif running; then
      # Overlays do not raise a backgrounded window, so focus it first.
      kitten @ --to "$SOCKET" focus-window --match recent:0 || true
      # Overlay the picker on the current window. It exits after switching
      # sessions, which closes the overlay.
      kitten @ --to "$SOCKET" launch --type=overlay --title "kitty-sessions" \
        "$self"
    else
      # No sessionizer yet: start one with the picker as its first window.
      kitty --detach --listen-on "$SOCKET" "$self"
    fi
    ;;
  *)
    open_session "$dir/$1" || notify_error "$1"
    ;;
esac
