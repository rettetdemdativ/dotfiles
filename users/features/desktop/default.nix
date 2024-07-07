{ inputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./fuzzel.nix
    ./gammastep.nix
    #./hyprland
    ./hyprpaper.nix
    ./kanshi.nix
    ./mako.nix
    ./niri
    (import ./swaybg.nix { wpPath = "/home/${username}/Pictures/Wallpapers"; })
    ./swayidle.nix
    ./waybar.nix
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
