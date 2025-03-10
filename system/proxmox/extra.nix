{ config, pkgs, ... }:

{
  # For media keys, etc.
  services.acpid = { enable = true; };
}
