{ inputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./git.nix
    ./helix.nix
    ./neovim.nix
    ./vscode.nix
    ./zed.nix
    ./zsh.nix
    ./ghostty.nix
    ./alacritty.nix
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

  home.persistence."/persist/home/${username}" = {
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
