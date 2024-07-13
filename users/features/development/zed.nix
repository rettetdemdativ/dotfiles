{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    zed-editor
  ];

  #xdg.configFile."nvim".source = ../../.config/nvim;
}
