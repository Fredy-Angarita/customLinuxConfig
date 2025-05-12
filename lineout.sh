#!/bin/bash

SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"
PORT="analog-output-lineout"
pactl set-sink-port $SINK $PORT
echo "$SINK $PORT" > ~/.config/customBash/last_port.conf