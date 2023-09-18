{ pkgs, ... }: {
  home.packages = with pkgs; [
    git
    git-crypt
    gnupg
    pinentry-qt

    nnn # File browser
    ncdu # TUI disk usage

    bitwarden-cli
    handlr-regex

    brightnessctl
  ];

  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  programs.git = {
    enable = true;
    userName = "Michael Koeppl";
    userEmail = "michael@koeppl.dev";
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "HotPurpleTrafficLight";
      vim_keys = true;
    };
  };
}
