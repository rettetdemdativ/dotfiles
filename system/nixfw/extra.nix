{ config, pkgs, ... }:

{
  services.hardware.bolt.enable = true;
  services.fwupd.enable = true;

  # Instead of TLP (better support for boost)
  services.auto-cpufreq = {
    enable = false;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # For media keys, etc.
  services.acpid = { enable = true; };
}
