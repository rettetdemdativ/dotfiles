{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  home.packages = with pkgs; [ aider-chat ];

  home.persistence."/persist" = {
    files = [ ".aider.conf.yml" ];
  };
}
