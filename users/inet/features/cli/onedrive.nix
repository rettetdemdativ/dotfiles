{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."onedrive/config".source = ../../.config/onedrive/config;
}
