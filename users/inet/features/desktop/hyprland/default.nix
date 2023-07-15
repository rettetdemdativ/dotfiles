{ inputs, lib, config, pkgs, ... }: {
  wayland.windowManager.hyprland.enable = true;
  xdg.configFile."hypr/hyprland.conf".source = ../../../.config/hypr/hyprland.conf;
}
