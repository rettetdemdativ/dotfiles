{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options =
      [ "size=3G" "mode=755" ]; # mode=755 so only root can write to those files
  };

  fileSystems."/nix" = {
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
