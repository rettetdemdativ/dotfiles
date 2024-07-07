{ inputs, lib, config, pkgs, username, ... }: {
  xdg.configFile."docker/daemon.json".source = ../../.config/docker/daemon_{username}.json;
}
