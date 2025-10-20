{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.aerc = {
    enable = true;
  };

  home.packages = with pkgs; [
    notmuch
    isync
  ];
}
