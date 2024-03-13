{ inputs, lib, config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
  xdg.configFile."waybar/config".source = ../../.config/waybar/config;
  xdg.configFile."waybar/style.css".source = ../../.config/waybar/style.css;
}
