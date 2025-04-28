{ inputs, lib, config, pkgs, username, ... }: {
  programs.newsboat = { enable = true; };

  home.persistence."/persist/home/${username}" = {
    directories = [ ".local/share/newsboat" ".config/newsboat" ];
  };
}
