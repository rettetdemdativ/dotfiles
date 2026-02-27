{ pkgs, username, ... }:
{
  imports = [
    ./comma.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    git-crypt
    gnupg
    pinentry-qt

    nnn
    gdu
    duf # TUI disk usage overview

    handlr-regex

    brightnessctl
  ];

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "HotPurpleTrafficLight";
      vim_keys = true;
    };
  };
}
