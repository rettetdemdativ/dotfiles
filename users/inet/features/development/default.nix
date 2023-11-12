{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./neovim.nix
    ./vscode.nix
    ./zsh.nix
    ./kitty.nix
    ./podman.nix
    #./docker.nix
  ];

  home.packages = with pkgs; [
    android-studio
    jetbrains.idea-ultimate
    kitty
    podman-compose
    docker-compose
    buildah
    virt-manager
    dbeaver
    hurl

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
