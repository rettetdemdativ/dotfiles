{ inputs, lib, config, pkgs, ... }: {
  wayland.windowManager.hyprland.enable = true;
  xdg.configFile."hypr/hyprland.conf".source = ../../.config/hypr/hyprland.conf;
  xdg.configFile."hypr/apply_monitor_setup.sh".source = ../../.config/hypr/apply_monitor_setup.sh;
}
