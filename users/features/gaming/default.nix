{ inputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [
    lutris
    mangohud
  ];
}
