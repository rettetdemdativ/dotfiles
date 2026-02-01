{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  xdg.configFile."hypr/hyprpaper.conf".source = ../../.config/hypr/hyprpaper.conf;
  xdg.configFile."hypr/restart_hyprpaper.sh".source = ../../.config/hypr/restart_hyprpaper.sh;
}
