{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
  };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/NIXCRYPT";

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
  };

  swapDevices = [{ device = "/dev/disk/by-label/NIXSWAP"; }];
}
