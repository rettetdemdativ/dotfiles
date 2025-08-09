{ inputs, lib, config, pkgs, username, ... }: {
  home.persistence."/persist/home/${username}" = {
    directories = [ ".cache/nix-index" ];
  };

  home.packages = with pkgs; [ comma nix-index ];
}
