{ inputs, config, pkgs, username, nixgl, ... }:
let
in rec {
  imports = [
    #inputs.niri.homeModules.niri
    ../features/general
    ../features/desktop/sway
    ../features/desktop/fuzzel.nix
    ../features/desktop/zathura.nix
    ../features/development/ghostty.nix
    ../features/development/neovim.nix
    ../features/development/zsh.nix
    ../features/cli
  ];

  nixGL = {
    packages = pkgs.nixgl;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

  programs.ghostty.package = with pkgs; (config.lib.nixGL.wrap ghostty);

  programs.home-manager.enable = true;

  home.packages = with pkgs; [ signal-desktop ];

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

  programs.bash = {
    enable = true;
    sessionVariables = { TERM = "xterm-256color"; };
    shellAliases = {
      apply-home = "$HOME/dotfiles/scripts/no_nixos/apply-home.sh";
      update-all = "$HOME/dotfiles/scripts/no_nixos/update.sh";
    };
    profileExtra = ''
      . "/home/${username}/.cargo/env"
      source "/home/${username}/.cargo/env"
    '';
  };

  #programs.niri = {
  #  enable = true;
  #  package = with pkgs; (config.lib.nixGL.wrap niri);
  #};

  programs.librewolf.package = config.lib.nixGL.wrap pkgs.librewolf;
}
