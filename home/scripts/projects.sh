#!/usr/bin/env bash
id=""
cmd=""

while [ $# -gt 0 ]; do
    case "$1" in
    --id)
        id="$2"
        shift 2
        ;;
    *)
        cmd="$1"
        shift
        ;;
    esac
done

[ -z "$cmd" ] && {
    echo "usage: projects [--id ID] <cmd>" >&2
    exit 1
}
[ -z "$id" ] && id="$cmd"

kitty -1 --app-id "$id" projects-picker "$cmd"
