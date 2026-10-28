#!/bin/bash
pkill slurp && exit 0

DIR="${SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"
[[ ! -d "$DIR" ]] && mkdir -p "$DIR"

JQ_MONITOR_GEO='
def format_geo:
  .x as $x | .y as $y |
  (.width / .scale | floor) as $w |
  (.height / .scale | floor) as $h |
  .transform as $t |
  if $t == 1 or $t == 3 then
    "\($x),\($y) \($h)x\($w)"
  else
    "\($x),\($y) \($w)x\($h)"
  end;
'

get_rectangles() {
  local active_workspace
  active_workspace=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .activeWorkspace.id')
  hyprctl monitors -j | jq -r --arg ws "$active_workspace" "${JQ_MONITOR_GEO} .[] | select(.activeWorkspace.id == (\$ws | tonumber)) | format_geo"
  hyprctl clients -j | jq -r --arg ws "$active_workspace" '.[] | select(.workspace.id == ($ws | tonumber)) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
}

RECTS=$(get_rectangles)

# Freeze the screen using hyprpicker (no zoom lens, silent)
hyprpicker -r -z >/dev/null 2>&1 &
PID=$!
sleep .1
SELECTION=$(echo "$RECTS" | slurp 2>/dev/null)
kill "$PID" 2>/dev/null

# Snap tiny/accidental drags to the window or monitor you clicked inside
if [[ $SELECTION =~ ^([0-9]+),([0-9]+)[[:space:]]([0-9]+)x([0-9]+)$ ]]; then
  if ((${BASH_REMATCH[3]} * ${BASH_REMATCH[4]} < 20)); then
    click_x="${BASH_REMATCH[1]}"
    click_y="${BASH_REMATCH[2]}"
    while IFS= read -r rect; do
      if [[ $rect =~ ^([0-9]+),([0-9]+)[[:space:]]([0-9]+)x([0-9]+) ]]; then
        rect_x="${BASH_REMATCH[1]}"
        rect_y="${BASH_REMATCH[2]}"
        rect_w="${BASH_REMATCH[3]}"
        rect_h="${BASH_REMATCH[4]}"
        if ((click_x >= rect_x && click_x < rect_x + rect_w && click_y >= rect_y && click_y < rect_y + rect_h)); then
          SELECTION="${rect_x},${rect_y} ${rect_w}x${rect_h}"
          break
        fi
      fi
    done <<<"$RECTS"
  fi
fi

[[ -z $SELECTION ]] && exit 0

FILE="$DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"

grim -g "$SELECTION" "$FILE" || exit 1

# Explicit MIME type so it pastes as an image, not text
wl-copy --type image/png <"$FILE"

# Notification (skipped quietly if libnotify isn't installed)
command -v notify-send >/dev/null &&
  notify-send "Screenshot saved to clipboard and file" "$FILE" -t 5000 -i "$FILE"
