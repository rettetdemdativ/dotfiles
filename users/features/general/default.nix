{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./chromium.nix ./librewolf.nix ./ladybird.nix ];
}
