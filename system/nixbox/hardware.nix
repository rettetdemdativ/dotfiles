{ inputs, lib, config, modulesPath, pkgs, ... }:

let kver = config.boot.kernelPackages.kernel.version;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.opengl.extraPackages = with pkgs; [ amdvlk ];
  # For 32 bit applications 
  hardware.opengl.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  hardware.graphics.enable = lib.mkDefault true;

  hardware.pulseaudio.enable = false;
}
