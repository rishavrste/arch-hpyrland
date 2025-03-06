allwallDIR="$HOME/Pictures/wallpapers"
# wallDIR="$HOME/Pictures/wallpapers/Best"
BestwallDIR="$allwallDIR/GOOD"
wallDIR=$(cat "$allwallDIR/selected_directory.txt")
scriptsDir="$HOME/.config/ags/scripts/color_generation"

focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')


last_wallpaper=$(cat "$wallDIR/current_wallpaper.txt")
#remove the previous name from current_wallpaper.txt
find "$wallDIR" -type f -name "current_wallpaper.txt" -exec rm {} \;
mapfile -d '' PICS < <(find "${wallDIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0 ! -name "$last_wallpaper")


# Select a random wallpaper from the filtered list
if [[ ${#PICS[@]} -eq 0 ]]; then
    echo "No wallpapers left to choose from!"
    mapfile -d '' PICS < <(find "${BestwallDIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0 ! -name "$last_wallpaper")
    exit 1
fi
RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

"$scriptsDir/switchwall.sh" $RANDOMPICS

wal -i $RANDOMPICS

pywalfox update

basename "$(basename "$RANDOMPICS")" > "$allwallDIR/current_wallpaper.txt"

cp $RANDOMPICS $HOME/.config/hypr/.wallpaper_current



exit 0


