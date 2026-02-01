{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  home.packages = with pkgs; [
    quickemu
    quickgui
  ];
}
