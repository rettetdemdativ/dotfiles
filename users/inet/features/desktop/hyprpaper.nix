{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."hypr/hyprpaper.conf".source =
    ../../.config/hypr/hyprpaper.conf;
}
