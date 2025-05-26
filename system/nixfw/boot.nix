{ inputs, lib, config, pkgs, ... }:

{
  boot = {
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    loader.systemd-boot.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

}
