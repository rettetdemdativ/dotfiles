{ pkgs, username, ... }: {
  imports = [ ./tmux.nix ];

  home.packages = with pkgs; [
    git-crypt
    gnupg
    pinentry-qt

    yazi # File browser
    ncdu # TUI disk usage
    duf # TUI disk usage overview

    handlr-regex

    brightnessctl
  ];

  programs.gpg = { enable = true; };

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
