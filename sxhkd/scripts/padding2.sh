#!/bin/bash

# Toggle for 16:9 aspect ratio padding
current_padding=$(bspc config -m focused left_padding)
if [ "$current_padding" -eq 1128 ]; then
  # Reset to no padding
  bspc config -m focused left_padding 0
  bspc config -m focused right_padding 0
else
  # Set padding for 16:9
  bspc config -m focused left_padding 1128
  bspc config -m focused right_padding 1128
fi
