{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{

  home.persistence."/persist" = {
    directories = [
      ".config/iamb"
      ".local/share/iamb"
    ];
  };

  home.packages = with pkgs; [ iamb ];
}
