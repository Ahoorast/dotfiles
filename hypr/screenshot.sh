#!/bin/sh
# usage: screenshot.sh [area]
dir="$(xdg-user-dir PICTURES)/Screenshots"
mkdir -p "$dir"
file="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"
if [ "$1" = area ]; then
  geom=$(slurp) || exit
  grim -g "$geom" "$file"
else
  grim "$file"
fi
wl-copy < "$file"
notify-send -i "$file" 'Screenshot copied' "$file"
