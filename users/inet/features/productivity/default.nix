{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./neovim
  ];

  home.packages = with pkgs; [
    neovim
    jetbrains.idea-ultimate
  ];
}
