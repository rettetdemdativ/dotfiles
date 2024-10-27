{ inputs, config, pkgs, username, ... }: {
  directories = [
    "dotfiles"
    "workspace"
    "Desktop"
    "Downloads"
    "Games"
    "Pictures"
    "Music"
    "Videos"
    "VMs"

    # Home manager
    {
      directory = ".local/state/nix/profiles";
      mode = "0700";
    }
    {
      directory = ".local/state/home-manager";
      mode = "0700";
    }

    {
      directory = ".config/nix";
      mode = "0700";
    }

    {
      directory = ".ssh";
      mode = "0700";
    }
    {
      directory = ".gnupg";
      mode = "0700";
    }
    {
      directory = ".local/share/keyrings";
      mode = "0700";
    }
    {
      directory = ".config/Signal";
      mode = "0700";
    }
    {
      directory = ".config/VSCodium";
      mode = "0700";
    }
    {
      directory = ".config/git";
      mode = "0700";
    }
    {
      directory = ".config/helix";
      mode = "0700";
    }
    {
      directory = ".config/zed";
      mode = "0700";
    }
    {
      directory = ".config/alacritty";
      mode = "0700";
    }
    {
      directory = ".config/kitty";
      mode = "0700";
    }
    {
      directory = ".config/btop";
      mode = "0700";
    }
    {
      directory = ".config/tidal-hifi";
      mode = "0700";
    }
    {
      directory = ".config/libreoffice";
      mode = "0700";
    }
    # These are treated differently as regular config files are imported
    # into these directories
    {
      directory = ".config/nvim";
      mode = "0700";
    }
    {
      directory = ".config/niri";
      mode = "0700";
    }
    {
      directory = ".config/systemd/user";
      mode = "0700";
    }
    # {
    #   directory = ".config/systemd/user/niri.service.wants";
    #   mode = "0700";
    # }
    # {
    #   directory = ".config/systemd/user/default.target.wants";
    #   mode = "0700";
    # }
    # {
    #   directory = ".config/systemd/user/graphical-session.target.wants";
    #   mode = "0700";
    # }
    # {
    #   directory = ".config/systemd/user/sockets.target.wants";
    #   mode = "0700";
    # }
    {
      directory = ".config/fuzzel";
      mode = "0700";
    }
    {
      directory = ".config/gammastep";
      mode = "0700";
    }
    {
      directory = ".config/hypr";
      mode = "0700";
    }
    {
      directory = ".config/hyprpaper";
      mode = "0700";
    }
    {
      directory = ".config/kanshi";
      mode = "0700";
    }
    {
      directory = ".config/mako";
      mode = "0700";
    }
    {
      directory = ".config/swaybg";
      mode = "0700";
    }
    {
      directory = ".config/swayidle";
      mode = "0700";
    }
    {
      directory = ".config/waybar";
      mode = "0700";
    }
    {
      directory = ".config/zathura";
      mode = "0700";
    }
    {
      directory = ".config/gtk-2.0";
      mode = "0700";
    }
    {
      directory = ".config/gtk-3.0";
      mode = "0700";
    }
    {
      directory = ".config/gtk-4.0";
      mode = "0700";
    }
    {
      directory = ".config/containers";
      mode = "0700";
    }
    {
      directory = ".config/dconf";
      mode = "0700";
    }
    {
      directory = ".config/environment.d";
      mode = "0700";
    }
    {
      directory = ".config/fontconfig";
      mode = "0700";
    }
    {
      directory = ".local/share/zed";
      mode = "0700";
    }
    {
      directory = ".config/ncmpcpp";
      mode = "0700";
    }
    # mpd
    {
      directory = ".config/mpd";
      mode = "0700";
    }
    {
      directory = ".local/share/mpd";
      mode = "0700";
    }
    # Misc
    {
      directory = ".local/share/Anki2";
      mode = "0700";
    }
    # VSCode
    {
      directory = ".vscode-oss";
      mode = "0700";
    }
    {
      directory = ".mozilla";
      mode = "0700";
    }
    {
      directory = ".ts3client";
      mode = "0700";
    }
    {
      directory = ".local/share/containers";
      mode = "0700";
    }
    {
      directory = ".local/share/JetBrains";
      mode = "0700";
    }
    {
      directory = ".gradle";
      mode = "0700";
    }
    {
      directory = ".android";
      mode = "0700";
    }
    {
      directory = ".cargo";
      mode = "0700";
    }
    {
      directory = ".rustup";
      mode = "0700";
    }
    {
      directory = ".m2";
      mode = "0700";
    }
    {
      directory = ".oh-my-zsh";
      mode = "0700";
    }
    {
      directory = ".config/oh-my-custom";
      mode = "0700";
    }
    {
      directory = ".local/share/Steam";
      mode = "0700";
    }
    {
      directory = ".local/share/lutris";
      mode = "0700";
    }
    {
      directory = ".local/share/wineprefixes";
      mode = "0700";
    }
    # Explicit allowed cache
    {
      directory = ".cache/JetBrains";
      mode = "0700";
    }
    {
      directory = ".cache/nixpkgs-review";
      mode = "0700";
    }
    {
      directory = ".cache/nix";
      mode = "0700";
    }
    {
      directory = ".cache/protontricks";
      mode = "0700";
    }
    {
      directory = ".cache/winetricks";
      mode = "0700";
    }
    {
      directory = ".cache/kitty";
      mode = "0700";
    }
    {
      directory = ".cache/oh-my-zsh";
      mode = "0700";
    }
  ];
  files = [
    ".config/mimeapps.list"
    ".cache/.keep"
  ];
}
