#!/bin/bash

last="NONE"
nid=0

low=10
critical=5

polltime=2

bat="BAT1"

str_time () {
  h=$(bc <<< "${1}/3600")
  m=$(bc <<< "(${1}%3600)/60")
  s=$(bc <<< "${1}%60")

  printf "%d h %02d min %02.0f sec\n" $h $m $s
}


calc_time_left () {
  voltage_now=$(cat "$1/voltage_now")
  charge_now=$(cat "$1/charge_now")
  current_now=$(cat "$1/current_now")
  
  energy=$(bc -l <<< "($voltage_now * $charge_now) / 1000000")
  power=$(bc -l <<< "($voltage_now * $current_now) / 1000000")
  hours=$(bc -l <<< "$energy / $power")

  echo $(bc -l <<< "$hours * 3600")
}


dismiss_last_notification () { 
  if [[ "$nid" -ne "0" ]]; then
    echo "poof"
    notify-send -r $nid -t 1 " "
    nid=0
  fi
}

send_power_warning () {
  time_left=$(str_time $(calc_time_left $2))
  if [[ "$nid" -ne "0" ]]; then
    nid=$(notify-send -p -r $nid -u critical -t 0 "Power" "Battery $1: $3%\nRemaining: $time_left")
  else
    nid=$(notify-send -p -u critical -t 0 "Power" "Battery $1: $3%\nRemaining: $time_left")
  fi
}

while true; do
  battery="/sys/class/power_supply/$bat"
  if [ -d $battery ]; then

    capacity=$(cat $battery/capacity)
    status=$(cat $battery/status)

    if [ "$last" != "FULL" ] && [ "$status" = "Full" ]; then
      dismiss_last_notification
      notify-send "Power" "Battery is full"
      last="FULL"
    fi

    # If low and discharging
    if [ "$last" != "CRITICAL" ] && [ "$status" = "Discharging" ] && [ $capacity -le $low ]; then
      send_power_warning "warning" $battery $capacity
      last=LOW polltime=2
    fi

    # If critical and discharging
    if [ "$status" = "Discharging" ] && [ $capacity -le $critical ]; then
      send_power_warning "critical" $battery $capacity
      last=CRITICAL
      polltime=2
    fi

    # If charging
    if [ "$status" = "Charging" ] && [ "$last" != "CHARGING" ]; then
      dismiss_last_notification  
      notify-send "Power" "Battery charging: $capacity%"
      last=CHARGING
      polltime=2
    fi

    # If disharging
    if [ "$status" = "Discharging" ] && [ "$last" != "LOW" ] && [ "$last" != "CRITICAL" ] && [ "$last" != "DISCHARGING" ]; then
      time_left=$(str_time $(calc_time_left $battery))
      notify-send "Power" "Battery discharging: $capacity%"
      last=DISCHARGING
      polltime=2
    fi
  else
    sleep 60
  fi
  sleep $polltime
done
