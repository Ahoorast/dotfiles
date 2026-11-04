#!/bin/sh
sel=$(cliphist list | fuzzel --dmenu --prompt 'clipboard: ') || exit
printf '%s' "$sel" | cliphist decode | wl-copy

# terminals paste with ctrl+shift+v, everything else with ctrl+v
case $(hyprctl activewindow -j | grep -o '"class": "[^"]*"') in
  *ghostty*|*foot*|*kitty*|*[Aa]lacritty*) mods='CTRL SHIFT' ;;
  *) mods='CTRL' ;;
esac
hyprctl dispatch "hl.dsp.send_shortcut({ mods = '$mods', key = 'V' })" >/dev/null
