{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./fuzzel.nix
    ./gammastep.nix
    ./mako.nix
    #./niri
    ./sway
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    # Hyprland is imported through its flake in flake.nix
    seatd
    swaylock-effects
    wdisplays
    grim
    slurp
    wl-clipboard
    cage # For running XWayland windows in separate "cage"

    numix-icon-theme
  ];
}
