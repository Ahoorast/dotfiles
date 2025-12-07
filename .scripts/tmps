#!/usr/bin/env bash

sessionName=$(pwd | tr '.' '_')

echo $sessionName

if tmux has-session -t="$sessionName" 2>/dev/null; then
    tmux attach -t "$sessionName"
else
    tmux new -s "$sessionName"
fi

