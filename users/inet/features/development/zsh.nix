{ inputs, lib, config, pkgs, ... }: {
  xdg.configFile."oh-my-custom/simple.zsh-theme".source =
    ../../themes/simple.zsh-theme;
}
