{ config, pkgs, ... }:

{
  # Necessary for the dispatcher script to work as otherwise the
  # systemd unit has no access to nmcli
  systemd.services.NetworkManager-dispatcher = {
    path = [ pkgs.networkmanager ];
  };

  # Adds dispatcher script that turns off WiFi if ethernet is connected
  networking.networkmanager.dispatcherScripts = [{
    source = pkgs.writeText "wifi-wired-exclusive" ''
      enable_disable_wifi ()
      {
          result=$(nmcli dev | grep "ethernet" | grep -w "connected")
          if [ -n "$result" ]; then
              nmcli radio wifi off
          else
              nmcli radio wifi on
          fi
      }

      if [ "$2" = "up" ]; then
          enable_disable_wifi
      fi

      if [ "$2" = "down" ]; then
          enable_disable_wifi
      fi
    '';
    type = "basic";
  }];

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
