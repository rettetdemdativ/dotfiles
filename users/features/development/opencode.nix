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
      ".config/opencode"
      ".local/share/opencode"
    ];
  };

  programs.opencode.enable = true;
}
