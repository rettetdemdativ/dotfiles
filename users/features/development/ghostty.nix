{ inputs, lib, config, pkgs, username, ... }: {
  home.packages = with pkgs;
    [ inputs.ghostty.packages."${pkgs.system}".default ];

  xdg.configFile."ghostty/config".source = ../../.config/ghostty/config;
}
