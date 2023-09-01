{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./mpd.nix ./ncmpcpp.nix ];

  home.packages = with pkgs; [
    pulsemixer
    pamixer # Volume controls
    mpv
    zathura
    feh
    mpd
    ncmpcpp
    tidal-hifi
    obs-studio
  ];
}
