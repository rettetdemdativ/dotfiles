{ inputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./mpd.nix
    ./cava.nix
    ./newsboat.nix
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

  home.persistence."/persist/home/${username}" = {
    directories = [ ".config/tidal-hifi" ];
  };
}
