#!/usr/bin/bash

identity=$(hyprctl hyprsunset identity get) || exit 1

if [[ "$identity" == *true* ]]; then
  hyprctl hyprsunset temperature 4000
else
  hyprctl hyprsunset identity
fi
