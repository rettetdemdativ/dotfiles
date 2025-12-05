{ inputs, lib, config, pkgs, username, ... }: {
  home.packages = with pkgs; [ git-crypt ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Michael Koeppl";
        email = "michael@koeppl.dev";
      };
      safe.directory = [ "/home/${username}/dotfiles/.git" ];
      gpg.format = "ssh";
      user.signingKey = "/home/${username}/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
    };
  };
}
