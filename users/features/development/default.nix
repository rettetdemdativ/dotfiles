{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./helix.nix
    ./neovim.nix
    ./vscode.nix
    ./zed.nix
    ./zsh.nix
    ./kitty.nix
    ./alacritty.nix
    ./podman.nix
    ./aider.nix
  ];

  home.packages = with pkgs; [
    android-studio
    jetbrains.idea-ultimate
    kitty
    podman-compose
    docker-compose
    buildah
    virt-manager
    distrobox
    quickemu
    beekeeper-studio
    bruno
    podman-desktop
    lefthook
    pre-commit

    # Used for various development tools
    nodePackages.prettier
    prettierd
    eslint_d
    lua
    nil # Nix LSP
    nixd # other Nix LSP
    nixfmt-classic # Nix formatter
    ripgrep
  ];
}
