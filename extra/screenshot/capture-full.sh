# Capture a full-size screenshot of all screens.

# Check if the target directory exists
screenshots="/home/ceri/captures"
mkdir -p "$screenshots/$(date +%Y-%m)"

# Take the screeshot and save it to the directory
fname="$screenshots/$(date +%Y-%m)/$(date +%Y-%m-%d_%H-%M-%S).png"
xfce4-screenshooter -f -c -s "$fname"
canberra-gtk-play -i camera-shutter &

# Copy to clipboard
# Notify image was copied
if [ -f $fname ]; then
  xclip -selection clipboard -t image/png -i "$fname"
  canberra-gtk-play -i window-attention-active &
  notify-send -i "$fname" -t 5000 "Capture" "Saved and copied to clipboard"
fi