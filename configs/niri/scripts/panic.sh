#!/bin/bash

CURRENT_WORKSPACE_AWI=$(niri msg -j workspaces | jq -r '.[] | select(.is_focused == true) | .active_window_id')

if [[ "$CURRENT_WORKSPACE_AWI" == "null" ]]; then
    niri msg action focus-workspace-previous
else
    niri msg action focus-workspace $(niri msg -j workspaces | jq 'sort_by(.idx)[-1].idx')
fi
