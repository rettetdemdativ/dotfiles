{ inputs, config, pkgs, ... }: {
  programs.neovim.enable = true;
  xdg.configFile."nvim".source = ../../.config/nvim;
}
