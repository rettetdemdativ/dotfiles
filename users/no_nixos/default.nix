{ inputs, config, pkgs, ... }: {
  imports = [ ../common.nix ];

  home.username = "inet";
  home.homeDirectory = "/home/inet";
  home.stateVersion = "23.11";
}
