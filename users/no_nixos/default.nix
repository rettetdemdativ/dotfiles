{ inputs, config, pkgs, username, nixgl, ... }:
let
in rec {
  imports = [
    #inputs.niri.homeModules.niri
    ../features/general
    ../features/development/ghostty.nix
    ../features/development/neovim.nix
    ../features/development/zsh.nix
    ../features/cli
  ];

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];

  programs.ghostty.package = with pkgs; (config.lib.nixGL.wrap ghostty);

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    signal-desktop
  ];

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  nixpkgs.config = {
    allowUnfree = true;
    # Workaround for https://github.com/nix-community/home-manager/issues/2942
    allowUnfreePredicate = (_: true);
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      apply-home = "$HOME/dotfiles/scripts/no_nixos/apply-home.sh";
      update-all = "$HOME/dotfiles/scripts/no_nixos/update.sh";
    };
  };

  #programs.niri = {
  #  enable = true;
  #  package = with pkgs; (config.lib.nixGL.wrap niri);
  #};
}
