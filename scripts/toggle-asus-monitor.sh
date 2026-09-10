#!/bin/bash
# Nome de porta da ASUS VP32AQ já mudou de HDMI-A-3 para HDMI-A-1 entre
# boots; identifica pela description em vez de fixar no nome da porta.
name=$(hyprctl monitors -j | jq -r '.[] | select(.description | contains("VP32AQ")) | .name')

if [ -n "$name" ]; then
    hyprctl keyword monitor "$name,disable"
else
    hyprctl keyword monitor "HDMI-A-1,2560x1440@60,4480x0,1"
fi
