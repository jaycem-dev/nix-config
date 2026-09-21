#!/usr/bin/env bash
items=(
    " Lock"
    " Suspend"
    " Reboot"
    " Shutdown"
    "󰍹 Power off monitors"
)
selected=$(printf '%s\n' "${items[@]}" | fuzzel --dmenu)

case $selected in
" Lock") swaylock ;;
" Suspend") systemctl suspend ;;
" Reboot") shutdown -r now ;;
" Shutdown") shutdown now ;;
"󰍹 Power off monitors") niri msg action power-off-monitors ;;
esac
