#!/bin/bash

entries="  Lock\n󰹆  Suspend\n󰍃  Logout\n󰜉  Reboot\n󰐥  Shutdown"

selected=$(echo -e $entries|wofi --width 100 --height 185 --dmenu --cache-file /dev/null --define content_halign=center --define prompt="Exit menu" | awk '{print tolower($2)}')

case $selected in
  lock)
    hyprlock;;
  logout)
    hyprctl dispatch exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
