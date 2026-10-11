#!/usr/bin/env bash
# ws-dots: waybar custom module — one dot per window on the focused

render() {
    local ws act dots
    ws=$(hyprctl activeworkspace -j | jq -r '.id // 0')
    act=$(hyprctl activewindow -j | jq -r '.address // empty')
    # ${ws:-0}: hyprctl failure yields empty $ws, which --argjson would
    # reject; 0 matches no workspace, so render degrades to empty dots.
    dots=$(hyprctl clients -j | jq -r --argjson ws "${ws:-0}" --arg act "$act" '
        [ .[] | select(.workspace.id == $ws and (.floating | not)) ]
        | sort_by(.at[0], .at[1])
        | map(if .address == $act
              then "<span>󰝥</span>"
              else "<span>󰧞</span>" end)
        | join(" ")')
    jq -nc --arg text "$dots" '{text: $text}'
}

sock="${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"
render
nc -U "$sock" | while IFS= read -r line; do
    case "$line" in
        workspace* | focusedmon* | activespecial* | activewindow* | openwindow* | closewindow* | kill* | movewindow* | moveworkspace* | createworkspace* | destroyworkspace* | monitoradded* | monitorremoved* | swapwindow* | togglegroup | moveintogroup* | moveoutofgroup* | changefloatingmode* | fullscreen* | pin*)
            render
            ;;
    esac
done
