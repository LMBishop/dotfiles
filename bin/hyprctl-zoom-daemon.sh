#!/bin/bash

zoom=1

izoom () {
    if [ $(echo "scale=0;$zoom/1" | bc) -eq 4 ];
    then
        zoom=4
        return
    fi
    zoom=$(echo "$zoom + 0.2" | bc)
}

dzoom () {
    if [ $(echo "scale=0;$zoom/1" | bc) -eq 0 ];
    then
        zoom=1
        return
    fi
    zoom=$(echo "$zoom - 0.2" | bc)
}

while :
do
    message=$(nc -lU /tmp/hyprctl-zoom.sock)
    case $message in
        plus)
            izoom
            hyprctl keyword cursor:zoom_factor $zoom
            ;;
        minus)
            dzoom
            hyprctl keyword cursor:zoom_factor $zoom
            ;;
        *)
            echo "Invalid message received"
            ;;
    esac
done

