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
      ".claude"
    ];
  };

  programs.claude-code.enable = true;
}
