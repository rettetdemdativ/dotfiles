{ inputs, lib, config, pkgs, hostname, ... }: {
  fileSystems."/persist".neededForBoot = true;
}
