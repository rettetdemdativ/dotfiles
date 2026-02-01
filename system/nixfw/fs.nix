{
  inputs,
  lib,
  config,
  pkgs,
  hostname,
  ...
}:
{
  fileSystems."/home/inet".neededForBoot = true;
}
