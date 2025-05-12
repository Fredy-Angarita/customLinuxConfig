#!/bin/bash

if [ -f ~/.config/customBash/last_port.conf ]; then
  read SINK PORT < ~/.config/customBash/last_port.conf
  pactl set-sink-port "$SINK" "$PORT"
fi
