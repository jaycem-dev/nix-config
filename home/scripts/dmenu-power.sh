#!/usr/bin/env bash
items=(
    "Lock"
    "Suspend"
    "Reboot"
    "Shutdown"
    "Logout"
    "Power off monitors"
)
selected=$(printf '%s\n' "${items[@]}" | fuzzel --dmenu)

case $selected in
"Lock") swaylock ;;
"Suspend") systemctl suspend ;;
"Reboot") hyprshutdown -p "shutdown -r now" ;;
"Shutdown") hyprshutdown -p "shutdown now" ;;
"Logout") hyprshutdown ;;
"Power off monitors") hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })' ;;
esac
