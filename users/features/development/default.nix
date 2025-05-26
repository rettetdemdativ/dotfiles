{ inputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./git.nix
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
    lefthook
    pre-commit
    tig

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
