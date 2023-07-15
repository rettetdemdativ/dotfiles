{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./mpd.nix
    ./ncmpcpp.nix
  ];

  home.packages = with pkgs; [
    pulsemixer
    mpv
    zathura
    mpd
    ncmpcpp
    tidal-hifi
  ];
}
