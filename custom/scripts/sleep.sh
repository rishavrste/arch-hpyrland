swayidle -w timeout 600 'swaylock -f -c 000000' \
            timeout 1200 'systemctl suspend' \
            before-sleep 'swaylock -f -c 000000' &
