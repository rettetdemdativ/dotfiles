{ inputs, config, pkgs, username, ... }: {
  imports = [ ../common.nix ];
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
      {
        directory = ".local/share/waydroid";
        method = "symlink";
      }

      # Nix package maintenance
      ".cache/nixpkgs-review"
      ".cache/nix"
    ];
    files = [ ];
  };
}
