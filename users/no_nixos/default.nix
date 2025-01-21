{ inputs, config, pkgs, username, ... }: {
  imports = [ ../common.nix ];

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";
}
