{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./neovim
  ];

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    kitty
    htop
    zsh
    podman-compose
  ];
}
