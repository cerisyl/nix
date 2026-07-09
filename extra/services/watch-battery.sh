#!/run/current-system/sw/bin/bash

charge=$(cat "/sys/class/power_supply/BAT0/capacity")
status=$(cat "/sys/class/power_supply/BAT0/status")

notify_warn=0 # 20%
notify_crit=0 # 10%

while true; do
  if [ "$status" = "Discharging" ]; then
    # Only alert while discharging
    if [ "$charge" -le 10 ] && [ "$notify_crit" -eq 0 ]; then
      /run/current-system/sw/bin/canberra-gtk-play -i battery-low
      notify_crit=1
    elif [ "$charge" -le 20 ] && [ "$notify_warn" -eq 0 ]; then
      /run/current-system/sw/bin/canberra-gtk-play -i battery-caution
      notify_warn=1
    fi
  # Reset if charging
  else
    notify_warn=0
    notify_crit=0
  fi
  sleep 10
done
