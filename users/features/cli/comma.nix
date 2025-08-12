{ inputs, lib, config, pkgs, username, ... }: {
  home.packages = with pkgs; [ comma nix-index ];
}
