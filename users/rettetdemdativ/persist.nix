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
      directory = ".config/mpd";
      mode = "0700";
    }
    {
      directory = ".config/VSCodium";
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
      directory = ".local/share/zed";
      mode = "0700";
    }
    # Neovim
    {
      directory = ".local/share/nvim/lazy";
      mode = "0700";
    }
    {
      directory = ".local/share/nvim/mason";
      mode = "0700";
    }
    # mpd
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
      directory = ".mozilla/firefox";
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
    {
      directory = ".local/share/flatpak";
      mode = "0700";
    }
    {
      directory = ".var/app/com.valvesoftware.Steam";
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
  ];
}
