{ inputs, lib, config, pkgs, hostname, ... }: {
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/home/inet".neededForBoot = true;
}
