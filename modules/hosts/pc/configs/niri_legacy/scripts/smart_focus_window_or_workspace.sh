#!/bin/bash

OLD_WINDOW_ID=$(niri msg -j focused-window | jq -r '.id')

if [[ $1 == "down" ]]; then
    command='next'
    niri msg action focus-window-down
elif [[ $1 == "up" ]]; then
    command='prev'
    niri msg action focus-window-up
else
    echo 'Usage: script.sh [down|up]'
    exit 1
fi

NEW_WINDOW_ID=$(niri msg -j focused-window | jq -r '.id')

if [[ "$OLD_WINDOW_ID" == "$NEW_WINDOW_ID" ]]; then
    ~/.config/niri/scripts/smart_focus_workspace.sh "$command"
fi