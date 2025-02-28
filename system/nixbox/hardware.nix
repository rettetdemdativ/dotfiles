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

  # Handled by the nixos-hardware module
  # hardware.graphics = {
  #   # radv
  #   enable = true;
  #   enable32Bit = true;

  #   # amdvlk
  #   #extraPackages = with pkgs; [ amdvlk ];
  #   #extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  # };

  services.pulseaudio.enable = false;
}
