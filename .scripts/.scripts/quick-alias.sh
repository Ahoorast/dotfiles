#!/bin/bash

# Check if input is provided
if [ -z "$1" ]; then
    echo "Usage: $0 alias_name=\"command\""
    exit 1
fi

# Extract alias name and command from argument
ALIAS_DEF="$1"
ALIAS_NAME="${ALIAS_DEF%%=*}"
ALIAS_COMMAND="${ALIAS_DEF#*=}"

# Remove quotes if present
ALIAS_COMMAND="${ALIAS_COMMAND%\"}"
ALIAS_COMMAND="${ALIAS_COMMAND#\"}"

ZSHRC_FILE="$HOME/.zshrc"

# Check if alias already exists
if grep -q "alias $ALIAS_NAME=" "$ZSHRC_FILE"; then
    echo "Alias '$ALIAS_NAME' already exists in $ZSHRC_FILE"
else
    echo "alias $ALIAS_NAME=\"$ALIAS_COMMAND\"" >> "$ZSHRC_FILE"
    echo "Added alias: alias $ALIAS_NAME=\"$ALIAS_COMMAND\""
fi

# Source the .zshrc file
source "$ZSHRC_FILE"

