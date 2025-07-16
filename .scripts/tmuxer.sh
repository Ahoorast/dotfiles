#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(tmux ls -F '#{session_name}'| fzf)
fi


if [[ -z $selected ]]; then
    return
fi

tmux switch-client -t $selected || tmux attach -t $selected
