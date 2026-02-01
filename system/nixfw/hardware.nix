{
  inputs,
  lib,
  config,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.graphics.enable = lib.mkDefault true;
  hardware.bluetooth.enable = true;
}
