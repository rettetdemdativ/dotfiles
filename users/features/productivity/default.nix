{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./neomutt.nix
  ];
  home.packages = with pkgs; [ qalculate-gtk ];
}
