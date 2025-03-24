{ inputs, config, pkgs, username, ... }: {
  imports = [
    ../features/desktop
    ../features/development/ghostty.nix
    ../features/development/helix.nix
    ../features/development/neovim.nix
    ../features/development/vscode.nix
    ../features/development/zsh.nix
    ../features/general
    ../features/media
    ../features/cli
  ];
  # Most stuff in common.nix

  home.persistence."/persist/home/${username}" = {
    allowOther = true;
    directories = [
      ".ssh"
      ".gnupg"
      "dotfiles"
      "workspace"
      "Desktop"
      "Downloads"
      "Pictures"
      "Music"
      "Videos"
      "VMs"
      ".local/share/nvim/lazy"
      ".local/share/nvim/mason"
      ".local/share/mpd"
      ".local/share/Anki2"
      ".config/Signal"
      ".config/mpd"
      ".config/VSCodium"
      ".config/tidal-hifi"
      ".mozilla/firefox"
      ".librewolf"
      ".ts3client"

      ".local/share/containers"

      # Rust
      ".cargo"
      ".rustup"

      # Nix package maintenance
      ".cache/nixpkgs-review"
      ".cache/nix"
    ];
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nautilus
    #networkmanagerapplet

    # GTK configuration through gsettings
    # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
    glib
    signal-desktop

    # Fonts
    monaspace
    jetbrains-mono
    roboto
    inter
    mononoki
    cascadia-code

    # For this user these are imported separately
    distrobox
    nil # Nix LSP
    nixd # other Nix LSP
    nixfmt-classic # Nix formatter
    ripgrep
  ];

  home.sessionVariables = rec {
    EDITOR = "nvim";
    #DOCKER_HOST = "unix:///run/user/$UID/podman/podman.sock";
    MPD_HOST = "$HOME/.config/mpd/socket";
    GTK_THEME = "Adwaita-dark";
    NIXOS_OZONE_WL = "1";
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
      "image/jpeg" = [ "imv.desktop" ];
      "image/png" = [ "imv.desktop" ];
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
