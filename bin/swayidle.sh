exec swayidle -w \
    timeout 300 "notify-send 'Power' 'System will suspend soon due to inactivity'" \
    timeout 310 "swaylock" \
    timeout 315 "systemctl suspend" \
    before-sleep "swaylock"

