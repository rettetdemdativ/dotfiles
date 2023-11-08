{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."containers/containers.conf".source =
    ../../.config/containers/containers.conf;
  xdg.configFile."containers/storage.conf".source =
    ../../.config/containers/storage.conf;
}
