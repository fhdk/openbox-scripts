#!/usr/bin/env bash

Name=$(basename "$0")
Version="0.1"

if [[ -z $ICON_THEME ]]; then
    ICON_THEME="Moka"
fi

_usage() {
    cat <<- EOF
Usage:   $Name [options]

Options:
     -h      Display this message
     -v      Display script version
     -w      Switch between open windows
     -r      Program launcher & run dialog
     -m      Launcher click
     -l      Session logout choice

EOF
}

#  Handle command line arguments
while getopts ":hvqwcmrl" opt; do
    case $opt in
        h)
            _usage
            exit 0
            ;;
        v)
            echo -e "$Name -- Version $Version"
            exit 0
            ;;
        w)
            rofi -modi window -show window -hide-scrollbar \
                -eh 1 -padding 50 -line-padding 4
            ;;
        m)
            rofi -location 1 -yoffset 40 -xoffset 10 \
                -modi run,drun -show drun -line-padding 50 \
                -columns 2 -padding 50 -hide-scrollbar \
                -show-icons -drun-icon-theme "$ICON_THEME"
            ;;
        r)
            rofi -modi run,drun -show drun -line-padding 50 \
                -columns 2 -padding 50 -hide-scrollbar \
                -show-icons -drun-icon-theme "$ICON_THEME"
            ;;
        l)
            ANS=$(echo "  Lock|  Logout| ⏻ Reboot| ⏼ Shutdown" | \
                rofi -sep "|" -dmenu -i -p 'System ' "" -width 20 \
                -hide-scrollbar -eh 1 -line-padding 4 -padding 50 -lines 4)
            case "$ANS" in
                *Lock) lockscreen -- scrot ;;
                *Logout) loginctl terminate-session $(loginctl session-status | head -n 1 | awk '{print $1}') ;;
                *Reboot) systemctl reboot ;;
                *Shutdown) systemctl poweroff
            esac
            ;;
        *)
            echo -e "Option does not exist: -$OPTARG"
            _usage
            exit 1
    esac
done
shift $((OPTIND - 1))


exit 0

# DO NOT EDIT! This file will be overwritten by LXAppearance.
# Any customization should be done in ~/.gtkrc-2.0.mine instead.
