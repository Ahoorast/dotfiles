#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find . -type d -print | fzf)
fi


if [[ -z $selected ]]; then
    exit 0
fi

cd $selected
