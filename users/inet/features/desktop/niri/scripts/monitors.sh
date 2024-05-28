if [[ $1 == "laptop" ]]; then
  niri msg output eDP-1 on
elif [[ $1 == "home" ]]; then
  niri msg output DP-2 on
  niri msg output eDP-1 off
fi
