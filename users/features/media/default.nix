{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./mpd.nix ./ncmpcpp.nix ];

  programs.obs-studio = { enable = true; };

  home.packages = with pkgs; [
    pulsemixer
    pamixer # Volume controls
    mpv
    sioyek
    imv
    mpd
    ncmpcpp
    rhythmbox
    kid3
    tidal-hifi
    invidtui
  ];
}
