{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."mako/config".source = ../../../.config/mako/config;
}
