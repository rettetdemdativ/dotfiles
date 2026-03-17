{ inputs, lib, config, pkgs, ... }:
let
  inherit (lib) getExe;
  swayCfg = config.wayland.windowManager.sway;
in {
  home.packages = with pkgs; [
    # Hyprland is imported through its flake in flake.nix
    seatd
    wdisplays
    grim
    slurp
    wl-clipboard
    cage # For running XWayland windows in separate "cage"

    numix-icon-theme
  ];

  xdg.configFile."sway/config".source =
    ../../../.config/sway/config;
}
