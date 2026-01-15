{ inputs, lib, config, pkgs, username, ... }: {
  home.packages = with pkgs; [ tidal-hifi ];
}
