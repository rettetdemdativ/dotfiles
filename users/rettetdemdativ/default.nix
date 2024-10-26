{ inputs, lib, config, pkgs, username, ... }: {
  imports = [ ../common.nix ../features/gaming ];

  programs.zsh = {
    shellAliases = { steam_flatpak = "flatpak run com.valvesoftware.Steam"; };
  };
}
