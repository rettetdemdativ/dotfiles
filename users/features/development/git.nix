{ inputs, lib, config, pkgs, username, ... }: {
  home.packages = with pkgs; [ git-crypt ];

  programs.git = {
    enable = true;
    userName = "Michael Koeppl";
    userEmail = "michael@koeppl.dev";
    extraConfig = {
      safe.directory = [ "/home/${username}/dotfiles/.git" ];
      gpg.format = "ssh";
      user.signingKey = "/home/${username}/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
    };
  };
}
