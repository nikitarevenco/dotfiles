#!/bin/bash
DIR="$HOME/.config/dunst"

function get_volume {
    amixer get Master | grep -oP "\[([0-9]+)%\]" | head -1 | grep -oP "[0-9]+"
}

function is_mute {
    amixer get Master | grep '\[off\]' &> /dev/null
    if [ $? -eq 0 ]; then
        echo 1
    else
        echo 0
    fi
}

function send_notification {
    volume=$(get_volume)
    icon_name="$HOME/.config/dunst/icons/volume-high.svg"
    if [ "$volume" = "0" ]; then
        icon_name="$HOME/.config/dunst/icons/volume-mute.svg"
        bar=""
    elif [ "$volume" -lt "10" ]; then
        icon_name="$HOME/.config/dunst/icons/volume-low.svg"
    elif [ "$volume" -lt "30" ]; then
        icon_name="$HOME/.config/dunst/icons/volume-medium.svg"
    elif [ "$volume" -lt "70" ]; then
        icon_name="$HOME/.config/dunst/icons/volume-high.svg"
    fi
    dunstify "Volume $volume%" -i $icon_name -r 5555 -u normal -h int:value:$volume
}

case $1 in
    up)
        amixer set Master 5%+ > /dev/null
        send_notification
        ;;
    down)
        amixer set Master 5%- > /dev/null
        send_notification
        ;;
    mute)
        amixer set Master toggle > /dev/null
        mute=$(is_mute)
        if [ "$mute" -eq 1 ]; then
            icon_name="$DIR/icons/volume-muted.svg"
            dunstify "Muted" -i $icon_name -r 5555 -u normal -h int:value:0
        else
            send_notification
        fi
        ;;
    off)
        mute=$(is_mute)
        if [ "$mute" -eq 0 ]; then
            amixer set Master mute > /dev/null
        fi
        ;;
esac
