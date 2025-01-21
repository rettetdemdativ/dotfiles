{ inputs, config, pkgs, ... }: {
  imports = [ ../common.nix ];

  username = "inet";
  homeDirectory = "/home/inet";

  stateVersion = "23.11";
}
