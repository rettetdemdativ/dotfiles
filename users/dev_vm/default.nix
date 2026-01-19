{
  inputs,
  config,
  pkgs,
  username,
  ...
}:
let
in
rec {
  imports = [
    ../features/cli/comma.nix
    ../features/cli/tmux.nix
    ../features/development/neovim.nix
    ../features/development/opencode.nix
  ];

  programs.home-manager.enable = true;

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  nixpkgs.config = {
    allowUnfree = true;
    # Workaround for https://github.com/nix-community/home-manager/issues/2942
    allowUnfreePredicate = (_: true);
  };

  home.packages = with pkgs; [
    tig
    #poedit
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      apply-home = "$HOME/dotfiles/scripts/no_nixos/apply-home.sh";
      update-all = "$HOME/dotfiles/scripts/no_nixos/update.sh";
    };
  };

  home.sessionPath = [
    "$HOME/flutter/bin"
  ];

  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      TERM = "alacritty";
      PATH = "$PATH:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin";
    };
    shellAliases = {
      apply-home = "$HOME/dotfiles/scripts/dev_vm/apply-home.sh";
      update-all = "$HOME/dotfiles/scripts/dev_vm/update.sh";
      start-vm = "$HOME/dotfiles/scripts/no_nixos/proxmox/start_vm.sh";
      spice-connect = "$HOME/dotfiles/scripts/no_nixos/proxmox/spice-connect.sh";
    };
    profileExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)"
      fi
    '';
  };

  programs.tmux = {
    enable = true;
  };
}
