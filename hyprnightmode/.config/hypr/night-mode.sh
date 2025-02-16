#!/bin/bash

# Automatically get latitude and longitude
LOC=$(curl -s https://ipinfo.io/ | grep loc | awk -F '"' '{print $4}')
LAT=$(echo $LOC | cut -d',' -f1)
LON=$(echo $LOC | cut -d',' -f2)

# Check if Gammastep is already running
if pgrep -x "gammastep" > /dev/null; then
    # If active, disable it
    pkill gammastep
else
    # If not active, enable it with a color temperature of 4500K
    gammastep -O 4500 -l $LAT:$LON &
fi
