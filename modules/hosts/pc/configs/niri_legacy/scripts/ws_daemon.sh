#!/bin/bash

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/niri_ws_state.env"

update_state() {
    niri msg -j workspaces | jq -r '
        (.[] | select(.is_focused == true) | "CUR_NAME=\(.name)\nCUR_IDX=\(.idx)"),
        (.[] | select(.output == "DP-1") | select(.name != null) | "WS_IDX_\(.name | tostring)=\(.idx)")
    ' > "${STATE_FILE}.tmp"
    
    mv "${STATE_FILE}.tmp" "$STATE_FILE"
}

update_state

niri msg event-stream | while read -r event; do
    if [[ "$event" == *"Workspace"* ]]; then
        update_state
    fi
done