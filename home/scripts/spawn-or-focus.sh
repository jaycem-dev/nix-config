#!/usr/bin/env bash
WEBAPP_BROWSER="${WEBAPP_BROWSER:-brave-origin}" # needs to be a Chromium browser
WEBAPP_BROWSER_ID="${WEBAPP_BROWSER_ID:-brave}"  # the string that's added to the ID

MODE="$1"
ARGS=("${@:2}")
ID=""

if [ "${#ARGS[@]}" -ge 2 ] && [ "${ARGS[-2]}" = "--id" ]; then
    ID="${ARGS[-1]}"
    ARGS=("${ARGS[@]:0:${#ARGS[@]}-2}")
fi

[ -z "$ID" ] && ID="${ARGS[0]}"

CMD_ARGS=()
case "$MODE" in
app)
    CMD_ARGS=("${ARGS[@]}")
    ;;
tui)
    CMD_ARGS=(kitty -1 --app-id "$ID" "${ARGS[@]}")
    ;;
webapp)
    ID="$WEBAPP_BROWSER_ID-${ARGS[0]}__-Default"
    CMD_ARGS=("$WEBAPP_BROWSER" --app="https://${ARGS[0]}")
    ;;
*)
    echo "Usage: $(basename "$0") <mode> <args...> [--id <id>]"
    echo "Modes:"
    echo "  app    <command> [args...]"
    echo "  tui    <command> [args...]"
    echo "  webapp <url>"
    exit 1
    ;;
esac

# niri's focus-window requires a numeric window ID, not an app_id
ID=$(niri msg --json windows | jq -r --arg id "$ID" '[.[] | select(.app_id == $id) | .id][0] // empty')

if [ -n "$ID" ]; then
    niri msg action focus-window --id "$ID"
    exit
fi

niri msg action spawn -- "${CMD_ARGS[@]}"
