{ inputs, config, pkgs, username, ... }: {
  imports = [ ../common.nix inputs.niri.homeModules.niri ];

  programs.niri.enable = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  nixpkgs.config = {
    allowUnfree = true;
    # Workaround for https://github.com/nix-community/home-manager/issues/2942
    allowUnfreePredicate = (_: true);
  };
}
