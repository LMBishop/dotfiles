#!/bin/bash
set -uo pipefail

idleprog="hypridle"

isactive="$(systemctl --user is-active $idleprog)"
if [ "$isactive" = "active" ]; then
  systemctl --user stop $idleprog
  notify-send "Idle Inhibitor" "$idleprog suspended (systemd)"
else
  systemctl --user start $idleprog
  notify-send "Idle Inhibitor" "$idleprog resumed (systemd)"
fi

