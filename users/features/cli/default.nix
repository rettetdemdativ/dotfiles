{ pkgs, username, ... }: {
  home.packages = with pkgs; [
    git
    git-crypt
    gnupg
    pinentry-qt

    nnn # File browser
    ncdu # TUI disk usage
    duf # TUI disk usage overview

    bitwarden-cli
    handlr-regex

    brightnessctl
  ];

  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Michael Koeppl";
    userEmail = "michael@koeppl.dev";
    extraConfig = {
      safe.directory =
        [ "/home/${username}/dotfiles/.git" "/home/${username}/.cache/nix" ];
      gpg.format = "ssh";
      user.signingKey = "/home/${username}/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "HotPurpleTrafficLight";
      vim_keys = true;
    };
  };
}
