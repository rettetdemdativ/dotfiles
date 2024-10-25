{ inputs, lib, config, pkgs, username, ... }: {
  home.packages = with pkgs; [ aider-chat ];
}
