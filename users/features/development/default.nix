{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./helix.nix
    ./neovim.nix
    ./vscode.nix
    ./zed.nix
    ./zsh.nix
    ./ghostty.nix
    ./podman.nix
    #./qemu.nix
    ./aider.nix
  ];

  home.packages = with pkgs; [
    podman-compose
    docker-compose
    buildah
    distrobox
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
