#!/bin/bash

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/niri_ws_state.env"

source "$STATE_FILE" 2>/dev/null || exit 1

if [[ $1 == "next" || $1 == "prev" ]]; then
    if [[ $1 == "next" ]]; then
        TARGET_NAME=$((CUR_NAME + 1))
    else
        if [[ $CUR_NAME == "1" ]]; then
            exit
        fi
        TARGET_NAME=$((CUR_NAME - 1))
    fi
else
    TARGET_NAME=$1
fi

var_name="WS_IDX_$TARGET_NAME"
TGT_IDX=${!var_name}

if [[ -z "$TGT_IDX" ]]; then
    niri msg action focus-workspace "$TARGET_NAME"
    exit
fi

if [[ "$CUR_IDX" == "$TGT_IDX" ]]; then
    exit
fi

if (( CUR_NAME > TARGET_NAME )); then
    NEW_IDX=$(( TGT_IDX + 1 ))
    if (( CUR_IDX < TGT_IDX )); then
        NEW_IDX=$(( NEW_IDX - 1 ))
        TGT_IDX=$(( TGT_IDX - 1 ))
    fi
else
    NEW_IDX=$(( TGT_IDX - 1 ))
    if (( CUR_IDX > TGT_IDX )); then
        NEW_IDX=$(( NEW_IDX + 1 ))
        TGT_IDX=$(( TGT_IDX + 1 ))
    fi
fi

if (( TGT_IDX == 0 )); then
    TGT_IDX=1
fi

if (( CUR_IDX != NEW_IDX )); then
    niri msg action move-workspace-to-index "$NEW_IDX"
fi
niri msg action move-window-to-workspace "$TGT_IDX"
