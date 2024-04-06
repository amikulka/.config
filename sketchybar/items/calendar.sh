sketchybar --add item calendar right \
           --set calendar icon=􀧞 \
             label="$(date +'%a %d %b %I:%M %p')" \
             update_freq=10 \
              script="$PLUGIN_DIR/calendar.sh"

