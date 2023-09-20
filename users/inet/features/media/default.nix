{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./mpd.nix ./ncmpcpp.nix ];

  programs.obs-studio = {
    enable = true;
  };

  home.packages = with pkgs; [
    pulsemixer
    pamixer # Volume controls
    mpv
    zathura
    feh
    mpd
    ncmpcpp
    tidal-hifi
  ];
}
