{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    zed-editor
  ];

  xdg.configFile."zed".source = ../../.config/zed;
}
