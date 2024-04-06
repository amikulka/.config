#!/bin/bash

calendar=(
  icon=cal
  icon.font="$FONT:Semibold:13.0"
  icon.padding_right=0
  label.width=45
  label.align=right
  label.font="$FONT:Semibold:13.0"
  padding_left=10
  padding_right=10
  update_freq=10
  script="$PLUGIN_DIR/calendar.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
