{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ "amdgpu" ];
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    loader.systemd-boot.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_6_15;

    # Specific version
    #kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_15.override {
    #  argsOverride = rec {
    #    src = pkgs.fetchurl {
    #      url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
    #      sha256 = "sha256-036SvBa5YqMCXfFWZHva2QsttP82x6YTeBf+ge8/KKY=";
    #    };
    #    version = "6.15.8";
    #    modDirVersion = "6.15.8";
    #  };
    #});

    # For bisecting
    #Step #3.1 – put the version that git bisect asked me to test in (#1)
    #
    #Step #3.2 – clear out sha256
    #
    #Step #3.3 – run a nixos-rebuild boot
    #
    #Step #3.4 – grab the sha256 and put it into the sha256 field (#2)
    #
    #Step #3.5 – make sure the major version matches at (#3) and (#4)
    #kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_16.override { # (#4)
    #  argsOverride = rec {
    #    src = pkgs.fetchFromGitHub {
    #      owner = "torvalds";
    #      repo = "linux";
    #      # (#1) -> put the bisect revision here
    #      rev = "a765b9e6db4082eefe6e1581a9495518685e7abf";
    #      # (#2) -> clear the sha; run a build, get the sha, populate the sha
    #      sha256 = "sha256-FWZDrXxaTDNeGBSsuA9hKQQeHqczR2eY6FdGRaoQHIM=";
    #    };
    #    dontStrip = true;
    #    ignoreConfigErrors = true;
    #    # (#3) `head Makefile` from the kernel and put the right version numbers here
    #    version = "6.16.0";
    #    modDirVersion = "6.16.0-rc2";
    #  };
    #});

  };

}
