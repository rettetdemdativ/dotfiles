{ inputs, lib, config, pkgs, username, ... }: {
  imports = [
    ../common.nix
    ../features/gaming
    #../features/flatpak 
  ];

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
      ".config/libreoffice"
      ".mozilla/firefox"
      ".ts3client"

      ".local/share/containers"

      # IntelliJ
      ".config/JetBrains"
      ".local/share/JetBrains"
      ".cache/JetBrains"

      # Android Studio
      ".gradle"
      ".config/Google/AndroidStudio2022.3"
      ".android"

      # Rust
      ".cargo"
      ".rustup"

      # Maven, unfortunately
      ".m2"

      # Nix package maintenance
      ".cache/nixpkgs-review"
      ".cache/nix"

      # Steam
      ".local/share/Steam"
      ".local/share/lutris"
      ".local/share/wineprefixes"
      ".cache/protontricks"
      ".cache/winetricks"

      # Flatpak for Steam
      ".local/share/flatpak"
      ".var/app/com.valvesoftware.Steam"

      # Lutris
      "Games"
    ];
  };

  programs.zsh = {
    shellAliases = { steam_flatpak = "flatpak run com.valvesoftware.Steam"; };
  };
}
