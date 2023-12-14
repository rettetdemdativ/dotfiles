if [[ $1 == "laptop" ]]; then
  hyprctl keyword monitor eDP-1,preferred,auto,1
elif [[ $1 == "mirror" ]]; then
  hyprctl keyword monitor eDP-1,preferred,auto,1
  hyprctl keyword monitor preferred,auto,1,mirror,eDP-1
elif [[ $1 == "home" ]]; then
  hyprctl keyword monitor eDP-1,disable
fi
