#!/bin/bash

sketchybar --add event aerospace_workspace_change

# Query all monitors

  spaces=($(aerospace list-workspaces --all))
  
  for sid in "${spaces[@]}"; do

    space=(
      space=$sid
      icon.padding_left=10
      icon.padding_right=10
      icon="${sid}"
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
      script="$CONFIG_DIR/plugins/aerospace.sh $sid"
    )

    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid "${space[@]}" \
        --subscribe space.$sid mouse.clicked \
        label="$sid" \
        click_script="aerospace workspace $sid"
  done

space_creator=(
  icon=􀆊
  icon.font="$FONT:Semibold:14.0"
  padding_left=5
  padding_right=10
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator space_windows_change


space_creator=(
  icon=􀆊
  icon.font="$FONT:Semibold:14.0"
  padding_left=5
  padding_right=10
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator space_windows_change
