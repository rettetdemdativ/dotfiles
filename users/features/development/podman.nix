{ inputs, lib, config, pkgs, username, ... }: {
  xdg.configFile."containers/containers.conf".source =
    ../../.config/containers/containers_${username}.conf;
  xdg.configFile."containers/storage.conf".source =
    ../../.config/containers/storage_${username}.conf;
}
