{ inputs, config, pkgs, ... }: {
  imports = [
    ./features/desktop
    ./features/development
    ./features/general
    ./features/media
    ./features/cli
    ./features/productivity
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    chromium

    gnome.nautilus
    # GTK configuration through gsettings
    # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
    glib
    signal-desktop
    teamspeak_client

    # Fonts
    monaspace
    jetbrains-mono
    roboto
    inter
    mononoki
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      nix-shell = "nix-shell --command 'zsh'";
      monitor_laptop = "sh $HOME/.config/hypr/apply_monitor_setup.sh laptop";
      monitor_home = "sh $HOME/.config/hypr/apply_monitor_setup.sh home";
      monitor_mirror = "sh $HOME/.config/hypr/apply_monitor_setup.sh mirror";
      git_relief = "sh $HOME/dotfiles/scripts/git-relief.sh";

      dev_rust = "$HOME/dotfiles/scripts/activate-dev.sh languages/rust";
      dev_go = "$HOME/dotfiles/scripts/activate-dev.sh languages/go";
      dev_c = "$HOME/dotfiles/scripts/activate-dev.sh languages/c";
      dev_java = "$HOME/dotfiles/scripts/activate-dev.sh languages/java";
      dev_java11 = "$HOME/dotfiles/scripts/activate-dev.sh languages/java11";
      dev_nodejs = "$HOME/dotfiles/scripts/activate-dev.sh languages/nodejs";
      dev_python = "$HOME/dotfiles/scripts/activate-dev.sh languages/python3";
      dev_aws = "$HOME/dotfiles/scripts/activate-dev.sh stacks/aws";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];

      custom = "$HOME/.config/oh-my-custom";
      theme = "simple";
    };
  };

  home.sessionVariables = rec {
    EDITOR = "nvim";
    #DOCKER_HOST = "unix:///run/user/$UID/podman/podman.sock";
    ANDROID_HOME = "$HOME/workspace/Android";
    MPD_HOST = "$HOME/.config/mpd/socket";
    GTK_THEME = "Adwaita-dark";
  };

  gtk = {
    enable = true;

    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk3 = { extraConfig = { gtk-application-prefer-dark-theme = 1; }; };

    gtk4 = { extraConfig = { gtk-application-prefer-dark-theme = 1; }; };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];

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
