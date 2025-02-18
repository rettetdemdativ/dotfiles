{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./mpd.nix
    ./cava.nix
    #./ncmpcpp.nix
  ];

  programs.obs-studio = { enable = true; };

  home.packages = with pkgs; [
    pulsemixer
    pamixer # Volume controls
    mpv
    imv
    mpd
    cmus
    tidal-hifi
    invidtui
  ];
}
