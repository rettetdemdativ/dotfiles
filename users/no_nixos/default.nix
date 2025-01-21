{ inputs, config, pkgs, username, ... }: {
  imports = [ ../common.nix ];

  username = "${username}";
  homeDirectory = "/home/${username}";

  stateVersion = "23.11";
}
