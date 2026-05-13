#!/bin/bash

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/niri_workspace_history"
CURRENT_WORKSPACE=$(niri msg -j workspaces | jq -r '.[] | select(.is_focused == true) | .name')

if [[ "$CURRENT_WORKSPACE" == "$1" ]]; then
    dir=$(cat "$STATE_FILE" 2>/dev/null)
    if [[ -n "$dir" ]]; then
        ~/.config/niri/scripts/smart_focus_workspace.sh "$dir"
    fi
else
    ~/.config/niri/scripts/smart_focus_workspace.sh "$1"
    echo "$CURRENT_WORKSPACE" > "$STATE_FILE"
fi