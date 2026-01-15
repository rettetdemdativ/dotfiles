{ inputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./cava.nix
    ./kew.nix
    ./mpd.nix
    #./newsboat.nix
    #./streamlink.nix
    #./toot.nix
    #./ncmpcpp.nix
    ./tidal.nix
  ];

  programs.obs-studio = { enable = true; };

  home.packages = with pkgs; [
    pulsemixer
    pamixer # Volume controls
    mpv
    imv
    mpd
    cmus
  ];
}
