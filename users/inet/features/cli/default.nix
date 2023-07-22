{ inputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [
    git
    git-crypt
    gnupg
    pinentry_qt

    htop
    s-tui
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
}
