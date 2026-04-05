# Extract text from a partial-area screenshot using OCR

# Define temporary filename location
fname="/tmp/ocr.png"

# Take the screeshot and save it to the directory
xfce4-screenshooter -r -s $fname
canberra-gtk-play -i keyboard-action &

# Copy to clipboard
# Notify the image text was copied
if [ -f $fname ]; then
  output="$(tesseract $fname -)"
  echo $output | xclip -sel clip
  canberra-gtk-play -i window-attention-active &
  notify-send -i clipit-trayicon -t 5000 "Copied text" "$output"
fi

# Remove the file
rm $fname