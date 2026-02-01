{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../common.nix
    ../features/gaming
    ../features/gaming/luanti.nix
  ];

  home.persistence."/persist" = {
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

      # Nix package maintenance
      ".cache/nixpkgs-review"
      ".cache/nix"

      # Steam
      ".local/share/Steam"
      ".local/share/lutris"
      ".local/share/wineprefixes"
      ".cache/protontricks"
      ".cache/winetricks"

      # Lutris
      "Games"
    ];
    files = [ ".aider.conf.yml" ];
  };
}
