{ inputs, lib, config, pkgs, username, ... }: {
  home.packages = with pkgs; [ aider-chat ];

  home.persistence."/persist/home/${username}" = {
    files = [ ".aider.conf.yml" ];
  };
}
