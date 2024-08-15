#!/bin/bash

  source "$CONFIG_DIR/colors.sh"
  COLOR=$BACKGROUND_2
  if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    COLOR=$GREY
  fi
  sketchybar --set $NAME icon.highlight=$FOCUSED_WORKSPACE \
                         label.highlight=$FOCUSED_WORKSPACE \
                         background.border_color=$COLOR

  apps=$(aerospace list-windows --workspace $1 --format %{app-name} | sort | uniq)

  args=(--animate sin 10)

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi
  args+=(--set space.$1 label="$icon_strip")

  sketchybar -m "${args[@]}"
