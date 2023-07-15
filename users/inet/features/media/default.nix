{ inputs, lib, config, pkgs, ... }: {
  import = [
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
