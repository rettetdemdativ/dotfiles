{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./onedrive.nix
  ];

  home.packages = with pkgs; [
    git
    git-crypt
    gnupg
    pinentry_qt

    nnn # File browser
    ncdu # TUI disk usage
    nil # Nix LSP
    nixfmt # Nix formatter
    bitwarden-cli
    onedrive
    handlr-regex
  ];

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  programs.git = {
    enable = true;
    userName  = "Michael Koeppl";
    userEmail = "michael@koeppl.dev";
  };
}
