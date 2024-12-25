#!/bin/bash

entries="  Lock\n󰹆  Suspend\n󰹆  Suspend-then-Hibernate\n󰒲  Hibernate\n󰍃  Logout\n󰜉  Reboot\n󰐥  Shutdown"

selected=$(echo -e $entries|wofi --width 100 --height 212 --dmenu --cache-file /dev/null --define content_halign=center --define prompt="Exit menu" | awk '{print tolower($2)}')

case $selected in
  lock)
    swaylock;;
  logout)
    hyprctl dispatch exit;;
  suspend-then-hibernate)
    exec systemctl suspend-then-hibernate;;
  suspend)
    exec systemctl suspend;;
  hibernate)
    exec systemctl hibernate;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
