#!/usr/bin/env bash
action="${1:?Usage: $(basename "$0") <on|off>}"

if [ "$action" != on ] && [ "$action" != off ]; then
    echo "Usage: $(basename "$0") <on|off>" >&2
    exit 1
fi

case "${XDG_CURRENT_DESKTOP,,}" in
hyprland)
    if [ "$action" = on ]; then
        CMD=(hyprctl dispatch "hl.dsp.dpms({ action = [[enable]] })")
    else
        CMD=(hyprctl dispatch "hl.dsp.dpms({ action = [[disable]] })")
    fi
    ;;
niri)
    if [ "$action" = on ]; then
        CMD=(niri msg action power-on-monitors)
    else
        CMD=(niri msg action power-off-monitors)
    fi
    ;;
*)
    notify-send "toggle-display" "unsupported desktop: ${XDG_CURRENT_DESKTOP:-<unset>}"
    echo "$(basename "$0"): unsupported desktop: ${XDG_CURRENT_DESKTOP:-<unset>}" >&2
    exit 1
    ;;
esac

"${CMD[@]}"
