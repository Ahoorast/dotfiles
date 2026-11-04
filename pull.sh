#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

sync() { mkdir -p "$2"; rsync -a --delete --exclude .git "$1" "$2"; }

cp ~/.zshrc .zshrc
cp ~/.vimrc .vimrc
cp ~/.ideavimrc .ideavimrc
sync ~/.config/nvim/ nvim/

sync ~/.config/hypr/ hypr/
sync ~/.config/niri/ niri/
sync ~/.config/waybar/ waybar/
sync ~/.config/mako/ mako/
sync ~/.config/ghostty/ ghostty/
sync ~/.config/systemd/user/hyprland-session.target systemd/user/
sync ~/.config/herdr/config.toml herdr/

IDEA=~/.config/JetBrains/IntelliJIdea2026.1
sync "$IDEA/keymaps/" jetbrains/intellij/keymaps/
sync "$IDEA/options/linux/keymap.xml" jetbrains/intellij/options/linux/
for f in ui.lnf.xml vim_settings.xml; do sync "$IDEA/options/$f" jetbrains/intellij/options/; done
