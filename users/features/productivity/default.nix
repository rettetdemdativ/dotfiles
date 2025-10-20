{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./aerc.nix
  ];
  home.packages = with pkgs; [ qalculate-gtk ];
}
