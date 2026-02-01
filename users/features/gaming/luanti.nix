{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  home.packages = with pkgs; [ luanti-client ];

  home.persistence."/persist" = {
    directories = [ ".minetest" ];
  };
}
