#!/bin/bash
set -uo pipefail

changescript="$(pidof "inhibit-idle.sh" || true)"
if [ -n "$changescript" ]; then
    wait "$changescript"
fi

idleprog="hypridle"

isactive="$(systemctl --user is-active $idleprog)"
if [ "$isactive" = "active" ]; then
  echo "{\"text\": \"running\", \"alt\": \"running\", \"tooltip\": \"$idleprog is running\", \"class\": \"running\" }"
else
  echo "{\"text\": \"suspended\", \"alt\": \"suspended\", \"tooltip\": \"$idleprog is suspended\", \"class\": \"suspended\" }"
fi

