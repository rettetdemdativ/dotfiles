{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."containers/containers.conf".source =
    ../../.config/containers/containers.conf;
}
