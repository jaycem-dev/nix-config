#!/usr/bin/env bash
temp=${1:-4000}
if [ "$(hyprctl hyprsunset identity get 2>/dev/null)" = true ]; then
    hyprctl hyprsunset temperature "$temp"
else
    hyprctl hyprsunset identity
fi
