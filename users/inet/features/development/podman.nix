{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."containers/storage.conf".source =
    ../../.config/containers/storage.conf;
  xdg.configFile."containers/containers.conf".source =
    ../../.config/containers/containers.conf;
}
