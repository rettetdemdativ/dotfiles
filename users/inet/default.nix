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

      # Nix package maintenance
      ".cache/nixpkgs-review"
      ".cache/nix"
    ];
    files = [ ];
  };
}
