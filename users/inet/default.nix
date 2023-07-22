{ inputs, config, pkgs, ... }: {
  imports = [
    ./features/desktop
    ./features/development
    ./features/media
    ./features/cli
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Web
    librewolf

    cinnamon.nemo
    bitwarden
    signal-desktop

    # Fonts
    jetbrains-mono
    roboto
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtra = ''
      export DOCKER_HOST="unix:///run/user/$UID/podman/podman.sock";
      export EDITOR="nvim";
    '';
    shellAliases = {
      apply-users = "$HOME/dotfiles/scripts/apply-users.sh";
      nix-shell = "nix-shell --command 'zsh'";
      monitor_laptop = "sh $HOME/.config/hypr/apply_monitor_setup.sh laptop";
      monitor_home = "sh $HOME/.config/hypr/apply_monitor_setup.sh home";

      dev_rust = "$HOME/dotfiles/scripts/activate-dev.sh languages/rust";
      dev_go = "$HOME/dotfiles/scripts/activate-dev.sh languages/go";
      dev_c = "$HOME/dotfiles/scripts/activate-dev.sh languages/c";
      dev_nodejs = "$HOME/dotfiles/scripts/activate-dev.sh languages/nodejs";
      dev_aws = "$HOME/dotfiles/scripts/activate-dev.sh stacks/aws";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "x-scheme-handler/http" = [ "librewolf.desktop" ];
      "x-scheme-handler/https" = [ "librewolf.desktop" ];
      "text/html" = [ "librewolf.desktop" ];
      "application/x-extension-htm" = [ "librewolf.desktop" ];
      "application/x-extension-html" = [ "librewolf.desktop" ];
      "application/x-extension-shtml" = [ "librewolf.desktop" ];
      "application/x-extension-xht" = [ "librewolf.desktop" ];
      "application/x-extension-xhtml" = [ "librewolf.desktop" ];
      "application/xhtml+xml" = [ "librewolf.desktop" ];

      "video/webm" = [ "mpv.desktop" ];
      "video/ogg" = [ "mpv.desktop" ];
      "video/x-msvideo" = [ "mpv.desktop" ];
      "video/x-flv" = [ "mpv.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];

      "inode/directory" = [ "nnn.desktop" "nautilus.desktop" ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/inet/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = { };
}
