#!/bin/bash

OLD_WINDOW_TILE=$(niri msg -j focused-window | jq -r '.layout.pos_in_scrolling_layout[1]')

if [[ $1 == "down" ]]; then
    command='next'
    niri msg action move-window-down
elif [[ $1 == "up" ]]; then
    command='prev'
    niri msg action move-window-up
else
    echo 'Usage: script.sh [down|up]'
    exit 1
fi

NEW_WINDOW_TILE=$(niri msg -j focused-window | jq -r '.layout.pos_in_scrolling_layout[1]')

if (( OLD_WINDOW_TILE == NEW_WINDOW_TILE )); then
    ~/.config/niri/scripts/smart_move_to_workspace.sh "$command"
fi