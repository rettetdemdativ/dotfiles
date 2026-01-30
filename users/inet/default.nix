{ inputs, config, pkgs, username, ... }: {
  imports = [ ../common.nix ];
  # Most stuff in common.nix

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
    ];
    files = [ ];
  };

  programs.zsh = {
    profileExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)"
      fi
    '';
  };
}
