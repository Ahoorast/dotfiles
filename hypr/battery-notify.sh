#!/bin/sh
bat=/sys/class/power_supply/BAT0
notified=
while sleep 60; do
  if [ "$(cat $bat/status)" = Discharging ] && [ "$(cat $bat/capacity)" -lt 5 ]; then
    [ -z "$notified" ] && notify-send -u critical "Battery low" "$(cat $bat/capacity)% left, plug in" && notified=1
  else
    notified=
  fi
done
