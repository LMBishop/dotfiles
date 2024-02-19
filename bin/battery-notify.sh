#!/bin/sh

last="NONE"

low=15
critical=5

bat="BAT1"

while true; do

  battery="/sys/class/power_supply/$bat"
  if [ -d $battery ]; then

    capacity=$(cat $battery/capacity)
    status=$(cat $battery/status)

    if [ "$last" != "FULL" ] && [ "$status" = "Full" ]; then
      notify-send "Power" "Battery is full"
      last="FULL"
    fi

    # If low and discharging
    if [ "$last" != "LOW" ] && [ "$status" = "Discharging" ] && \
       [ $capacity -le $low ]; then
      notify-send "Power" "Battery warning: $capacity%"
      last=LOW
    fi

    # If critical and discharging
    if [ "$status" = "Discharging" ] && [ $capacity -le $critical ]; then
      notify-send "Power" "Battery critical: $capacity%"
      last=CRITICAL
    fi
  fi
  sleep 60
done
