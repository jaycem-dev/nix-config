#!/usr/bin/env bash
# Select a region and copy it to the clipboard.
geometry="$(slurp 2>/dev/null)" || exit 0
[ -z "$geometry" ] && exit 0

if grim -g "$geometry" - | wl-copy; then
    notify-send "Screenshot" "Copied to clipboard"
else
    notify-send "Screenshot" "Failed to take screenshot"
    exit 1
fi
