{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./neovim.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    kitty
    podman-compose
    buildah
    virt-manager

    # Used for various development tools
    nodePackages.prettier
    lua
    nil # Nix LSP
    nixfmt # Nix formatter
    ripgrep
  ];
}
