{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."hypr/hyprland.conf".source = ../../.config/hypr/hyprland.conf;
  xdg.configFile."hypr/apply_monitor_setup.sh".source =
    ../../.config/hypr/apply_monitor_setup.sh;
  xdg.configFile."systemd/user/hyprland-session.target".source = ../../.config/hypr/hyprland-session.target;
}
