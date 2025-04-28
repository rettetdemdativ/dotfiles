{ config, pkgs, ... }:

{
  services.hardware.bolt.enable = true;
  services.fwupd.enable = true;

  # Disable to use TLP instead
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      USB_AUTOSUSPEND = 0;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      #CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      #CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  };

  # Instead of TLP (better support for boost)
  #services.auto-cpufreq = {
  #  enable = false;
  #  settings = {
  #    battery = {
  #      governor = "powersave";
  #      turbo = "never";
  #    };
  #    charger = {
  #      governor = "performance";
  #      turbo = "auto";
  #    };
  #  };
  #};

  # For media keys, etc.
  services.acpid = { enable = true; };

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchDocked = "suspend";
    lidSwitchExternalPower = "suspend";
    extraConfig = ''
      HandlePowerKey=hibernate
      HandleSuspendKey=suspend
      HandleHibernateKey=hibernate
      IdleAction=ignore
    '';
  };
}
