#! /bin/bash 
picom --experimental-backends -f --config /home/kevin/.config/picom/config &
/usr/bin/emacs --daemon &
/home/kevin/.local/bin/randobg.sh 1080p &
#nm-applet &
#/usr/bin/unclutter -b &
