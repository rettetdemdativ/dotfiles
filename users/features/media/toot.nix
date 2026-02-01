{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  home.packages = with pkgs; [ toot ];

  home.persistence."/persist" = {
    files = [ ".config/toot/config.json" ];
  };

  xdg.configFile."toot/settings.toml".text = ''
    [tui]
    media_viewer = "imv"
  '';
}
