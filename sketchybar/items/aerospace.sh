#!/bin/bash

monitor_ids=($(aerospace list-monitors --format %{monitor-id}))

for monitor in "${monitor_ids[@]}"; do
  workspaces=($(aerospace list-workspaces --monitor ${monitor}))
  for sid in "${workspaces[@]}"; do
    space=(
      space=${monitor}
      icon="${sid}"
      icon.padding_left=10
      icon.padding_right=10
      padding_left=2
      padding_right=2
      label.padding_right=15
      icon.highlight_color=$RED
      label.color=$GREY
      label.highlight_color=$WHITE
      label.font="sketchybar-app-font:Regular:14.0"
      label.y_offset=-1
      background.height=20
      background.color=$BACKGROUND_1
      background.border_color=$BACKGROUND_2
      click_script="aerospace workspace $sid"
      script="$PLUGIN_DIR/aerospace.sh $sid"
    )

    sketchybar --add item space.$sid left    \
               --set space.$sid "${space[@]}" \
               --subscribe space.$sid aerospace_workspace_change


  done
done


space_creator=(
  icon=􀆊
  icon.font="$FONT:Semibold:14.0"
  padding_left=5
  padding_right=10
  label.drawing=off
  display=active
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \

