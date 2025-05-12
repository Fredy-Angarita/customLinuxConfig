#!/bin/bash

SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"
PORT="analog-output-headphones"
pactl set-sink-port $SINK $PORT
echo "Switched to headphones"
echo "$SINK $PORT" > ~/.config/customBash/last_port.conf    
