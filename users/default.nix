{ inputs, config, lib, pkgs, username, ... }:

let
  impermanence = builtins.fetchTarball
    "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in {
  imports = [ (./. + "/${username}") "${impermanence}/home-manager.nix" ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.persistence."/nix/persist/home/${username}" = {
    directories = [
      ".ssh"
      ".gnupg"
      "dotfiles"
      "workspace"
      "Desktop"
      "Downloads"
      "Pictures"
      "Videos"
      "VMs"
    ];
    files = [ ".zsh_history" ];
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
    # Workaround for https://github.com/nix-community/home-manager/issues/2942
    allowUnfreePredicate = (_: true);
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = { warn-dirty = false; };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
