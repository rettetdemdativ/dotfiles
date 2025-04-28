{ inputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./helix.nix
    ./neovim.nix
    ./vscode.nix
    ./zed.nix
    ./zsh.nix
    ./ghostty.nix
    ./podman.nix
    #./android.nix
    #./qemu.nix
    #./aider.nix
  ];

  home.packages = with pkgs; [
    podman-compose
    docker-compose
    buildah
    distrobox
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
