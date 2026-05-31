#!/bin/bash
if hyprctl monitors | grep -q "Monitor HDMI-A-3"; then
    hyprctl keyword monitor HDMI-A-3,disable
else
    hyprctl keyword monitor HDMI-A-3,2560x1440@60,4480x0,1
fi
