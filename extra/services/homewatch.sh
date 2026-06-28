# Define targets
declare -a targets=("Arduino" "Floorp" "Projects" "thunderbird")

# Remove if created
inotifywait -m -e create ~/. | while read FILE; do
  echo $FILE
  for i in "${!targets[@]}"; do
    dir="${targets[$i]}"
    if test -d "/home/ceri/$dir"; then
      rmdir "/home/ceri/$dir"
    fi
  done
done