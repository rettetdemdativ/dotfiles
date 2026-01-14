{ inputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./mpd.nix
    ./cava.nix
    ./newsboat.nix
    ./streamlink.nix
    ./toot.nix
    ./kew.nix
  ];

  programs.obs-studio = { enable = true; };

  home.packages = with pkgs; [
    pulsemixer
    pamixer # Volume controls
    mpv
    imv
    mpd
    tidal-hifi
  ];

  home.persistence."/persist/home/${username}" = {
    directories = [ ".config/tidal-hifi" ];
  };
}
