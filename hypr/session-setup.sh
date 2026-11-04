#!/bin/sh
# Under a bare "Hyprland" GDM session (not the uwsm one) nothing activates the
# systemd user graphical-session.target, so xdg-desktop-portal never starts and
# Flatpak apps (Telegram, etc.) can't open links / file pickers.
# This pushes the compositor env into the systemd/dbus activation environment
# and starts a minimal session target that pulls in graphical-session.target.
dbus-update-activation-environment --systemd \
  WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE HYPRLAND_INSTANCE_SIGNATURE
systemctl --user import-environment \
  WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE HYPRLAND_INSTANCE_SIGNATURE
systemctl --user start hyprland-session.target
