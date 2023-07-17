{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."hypr/hyprpaper.conf".source = ../../.config/hypr/hyrpaper.conf;
}
