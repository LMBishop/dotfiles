#/bin/bash

case $1 in
    i)
        echo "plus" | nc -NU /tmp/hyprctl-zoom.sock
        ;;
    d)
        echo "minus" | nc -NU /tmp/hyprctl-zoom.sock
        ;;
    *)
        echo "Usage: $0 [id]"
        exit 1
        ;;
esac

