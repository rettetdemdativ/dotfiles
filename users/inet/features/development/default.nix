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

    clang
    rustup
    go
    # Used for various development tools
    nodejs_20
    nodePackages.prettier
  ];
}
