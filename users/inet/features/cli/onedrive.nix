{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."onedrive".source = ../../.config/onedrive;
}
