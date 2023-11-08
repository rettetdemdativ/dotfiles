{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."docker/daemon.json".source = ../../.config/docker/daemon.json;
}
