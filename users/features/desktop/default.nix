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
    ./gammastep.nix
    ./mako.nix
    ./sway
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    seatd
    swaylock-effects

    # Display management
    wdisplays

    # Screenshot stuff
    grim
    slurp
    wl-clipboard

    numix-icon-theme
  ];
}
