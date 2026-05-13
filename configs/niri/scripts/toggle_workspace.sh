#!/bin/bash

CURRENT_WORKSPACE=$(niri msg -j workspaces | jq -r '.[] | select(.is_focused == true) | .name')

if [ "$CURRENT_WORKSPACE" = $1 ]; then
    niri msg action focus-workspace-previous
else
    niri msg action focus-workspace $1
fi
