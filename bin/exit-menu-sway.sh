#!/bin/bash

#entries="  Lock\n󰹆  Suspend\n󰹆  Suspend-then-Hibernate\n󰒲  Hibernate\n󰍃  Logout\n󰜉  Reboot\n󰐥  Shutdown"
entries="  Lock\n󰹆  Suspend\n󰒲  Hibernate\n󰍃  Logout\n󰜉  Reboot\n󰐥  Shutdown"

selected=$(echo -e $entries|wofi --width 100 --height 212 --dmenu --cache-file /dev/null --define content_halign=center --define prompt="Exit menu" | awk '{print tolower($2)}')

case $selected in
  lock)
    hyprlock;;
  logout)
    hyprctl dispatch exit;;
  suspend)
    exec systemctl suspend-then-hibernate;;
  hibernate)
    exec systemctl hibernate;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
