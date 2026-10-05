#!/usr/bin/env bash
cmd="$1"
search_dir="${2:-$HOME/Projects}"

[ -z "$cmd" ] && {
    echo "usage: projects-picker <cmd> [search_dir]" >&2
    exit 1
}

selected=$(fd -t d --max-depth 1 . "$search_dir" --format '{/}' | fzf --reverse --margin=2 --prompt="Select project ($cmd)> ")
[ -z "$selected" ] && exit 0

cd "$search_dir/$selected" && exec "$cmd"
