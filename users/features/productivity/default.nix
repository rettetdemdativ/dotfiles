{ inputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [ qalculate-gtk ];
}
