{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  home.packages = with pkgs; [ tidal-hifi ];

  home.persistence."/persist" = {
    directories = [ ".config/tidal-hifi" ];
  };
}
