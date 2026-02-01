{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./git.nix
    ./neovim.nix
    ./vscode.nix
    ./zed.nix
    ./zsh.nix
    ./alacritty.nix
    ./ghostty.nix
    ./podman.nix
    ./ollama.nix
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
    nixfmt # Nix formatter
    ripgrep
  ];

  home.persistence."/persist" = {
    directories = [
      ".local/share/containers"

      # IntelliJ
      ".config/JetBrains"
      ".local/share/JetBrains"
      ".cache/JetBrains"

      # Android Studio
      ".gradle"
      #".config/Google/AndroidStudio2024.3"
      ".android"

      # Rust
      ".cargo"
      ".rustup"

      # Maven, unfortunately
      ".m2"
    ];
    files = [ ".terraformrc" ];
  };
}
