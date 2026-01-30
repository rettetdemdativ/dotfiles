{ inputs, lib, config, pkgs, hostname, ... }: {
  fileSystems."/home/rettetdemdativ".neededForBoot = true;
}
