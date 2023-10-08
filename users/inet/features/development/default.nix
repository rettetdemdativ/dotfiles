{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./neovim.nix ./kitty.nix ];

  home.packages = with pkgs; [
    android-studio
    jetbrains.idea-ultimate
    kitty
    podman-compose
    buildah
    virt-manager
    dbeaver

    # Used for various development tools
    nodePackages.prettier
    prettierd
    eslint_d
    lua
    nil # Nix LSP
    nixfmt # Nix formatter
    ripgrep
  ];
}
