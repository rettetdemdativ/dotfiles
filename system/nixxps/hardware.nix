{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-13-9380
  ];

  hardware.opengl.enable = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
