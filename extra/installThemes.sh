# TODO: Integrate into builds
checkConnection=$(ping -c1 dropbox.com | grep "100% packet loss")
if [[ "$checkConnection" == "" ]]; then
  curl -L -o /tmp/themes.zip "https://www.dropbox.com/scl/fo/lym7a5h68pxibl2fwkl4r/AObWCCVHSwMMA6YnJHckmzo?rlkey=hsjqv6dnle5ysgsppyj0gtfm7&st=m5axlvg7&dl=1" -s
  getNewHash=$(cat /tmp/themes.zip | md5sum | awk "{print $1}")
  getCurrentHash=$(cat /home/ceri/.themeHash)
  if [[ "$getNewHash" != "$getCurrentHash" ]]; then
    cat /tmp/themes.zip | md5sum | awk "{print $1}" > /home/ceri/.themeHash
    unzip -qq /tmp/themes.zip -d /tmp/themes
    for zip in $(fd ".*\.zip$" /tmp/themes); do
      theme=$(basename $(dirname $zip))
      file=$(basename $zip)
      type=${file%.*}
      if [[ $zip == *"main"* ]] || [[ $zip == *"window"* ]]; then
        mkdir -p "/home/ceri/.local/share/themes/$theme-$type"
        rm -rf "/home/ceri/.local/share/themes/$theme-$type"
        unzip -qq $zip -d "/home/ceri/.local/share/themes/$theme-$type"
      else
        mkdir -p "/home/ceri/.icons/$theme-$type"
        rm -rf "/home/ceri/.icons/$theme-$type"
        unzip -qq $zip -d "/home/ceri/.icons/$theme-$type"
      fi
    done
    rm -rf /tmp/themes
  else
    echo "Hash signifies no change to themes.zip. Skipping installThemes hook..."
  fi
  rm -rf /tmp/themes.zip
else
  echo "No ping reply from Dropbox. Skipping installThemes hook..."
fi