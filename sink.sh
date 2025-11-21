#!/bin/bash

SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"
PORT1="analog-output-headphones"
PORT2="analog-output-lineout"
ACTIVE=$(pactl list sinks | grep 'Puerto Activo:' | awk -F': ' '{ print $2 }')

if [ "$ACTIVE" == "$PORT1" ]; then
	echo "Switched to Speakers"
pactl set-sink-port $SINK $PORT2
echo "$SINK $PORT2" > ~/.config/customBash/last_port.conf		
fi

if [ "$ACTIVE" == "$PORT2" ]; then
	echo "Switched to headphones"
pactl set-sink-port $SINK $PORT1
echo "$SINK $PORT1" > ~/.config/customBash/last_port.conf
fi
