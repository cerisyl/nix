# Capture a partial-area screenshot.

# Check if the target directory exists
screenshots="/home/ceri/captures"
mkdir -p "$screenshots/$(date +%Y-%m)"

# Take the screeshot and save it to the directory
fname="$screenshots/$(date +%Y-%m)/$(date +%Y-%m-%d_%H-%M-%S).png"
xfce4-screenshooter -r -c -s "$fname"

# Copy to clipboard
# Notify image was copied
if [ -f $fname ]; then
  xclip -selection clipboard -t image/png -i "$fname"
  notify-send -i "$fname" -t 5000 "Capture" "Saved and copied to clipboard"
  canberra-gtk-play -i window-attention-active &
fi