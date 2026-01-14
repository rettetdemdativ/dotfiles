{ inputs, lib, config, pkgs, username, ... }: {
  home.packages = with pkgs; [ tidal-hifi ];

  home.persistence."/persist/home/${username}" = {
    directories = [ ".config/tidal-hifi" ];
  };
}
