{ inputs, config, pkgs, username, nixgl, ... }:
let
in rec {
  imports = [
    #inputs.niri.homeModules.niri
    ../features/general
    ../features/desktop/sway
    (import ../features/desktop/swaybg.nix { wpPath = "/home/${username}/Pictures/Wallpapers"; })
    ../features/desktop/fuzzel.nix
    ../features/desktop/zathura.nix
    ../features/development/ghostty.nix
    ../features/development/neovim.nix
    ../features/development/vscode.nix
    ../features/development/zsh.nix
    ../features/cli
    ../features/media
    ../features/productivity
  ];

  nixGL = {
    packages = pkgs.nixgl;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

  programs.ghostty.package = with pkgs; (config.lib.nixGL.wrap ghostty);

  programs.home-manager.enable = true;

  home.packages = with pkgs; [ android-studio tig ];

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

  home.sessionPath = [
    "$HOME/flutter/bin"
    #"$HOME/workspace/android-studio/bin"
  ];

  programs.bash = {
    enable = true;
    sessionVariables = { 
      EDITOR = "nvim";
      TERM = "xterm-256color"; 
      ANDROID_HOME = "$HOME/Android/Sdk";
      ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    };
    shellAliases = {
      apply-home = "$HOME/dotfiles/scripts/no_nixos/apply-home.sh";
      update-all = "$HOME/dotfiles/scripts/no_nixos/update.sh";
      start-vm = "$HOME/dotfiles/scripts/no_nixos/proxmox/start_vm.sh";
      spice-connect = "$HOME/dotfiles/scripts/no_nixos/proxmox/spice-connect.sh";
    };
    profileExtra = ''
      . "/home/${username}/.cargo/env"
      source "/home/${username}/.cargo/env"
      eval "$(ssh-agent -s)"
    '';
    initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
            export QT_QPA_PLATFORM=wayland
            export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
            export XDG_SESSION_TYPE=wayland
            #export XDG_CURRENT_DESKTOP=sway
            export _JAVA_AWT_WM_NONREPARENTING=1
            export MOZ_ENABLE_WAYLAND=1
            export MOZ_WEBRENDER=1
            exec sway
        fi
    '';
  };

  programs.tmux = {
    enable = true;
  };

  #programs.niri = {
  #  enable = true;
  #  package = with pkgs; (config.lib.nixGL.wrap niri);
  #};

  programs.librewolf.package = config.lib.nixGL.wrap pkgs.librewolf;
}
