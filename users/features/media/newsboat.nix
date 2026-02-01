{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  programs.newsboat = {
    enable = true;
  };

  home.persistence."/persist" = {
    directories = [
      ".local/share/newsboat"
      ".config/newsboat"
    ];
  };
}
