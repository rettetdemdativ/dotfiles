{ inputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./fuzzel.nix
    ./gammastep.nix
    ./kanshi.nix
    ./mako.nix
    #./niri
    ./sway
    (import ./swaybg.nix { wpPath = "/home/${username}/Pictures/Wallpapers"; })
    ./swayidle.nix
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
