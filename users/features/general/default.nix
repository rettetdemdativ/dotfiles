{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./chromium.nix ./librewolf.nix ./iamb.nix ];
}
