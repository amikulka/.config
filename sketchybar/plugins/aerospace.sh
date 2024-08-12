#!/bin/bash

  source "$CONFIG_DIR/colors.sh"
  COLOR=$BACKGROUND_2
  if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    COLOR=$GREY
  fi
  sketchybar --set $NAME icon.highlight=$FOCUSED_WORKSPACE \
                         label.highlight=$FOCUSED_WORKSPACE \
                         background.border_color=$COLOR

