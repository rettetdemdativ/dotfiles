{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./mpd
    ./ncmpcpp
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
