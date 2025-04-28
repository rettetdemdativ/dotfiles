{ config, pkgs, ... }:

{
  services.hardware.bolt.enable = true;
  services.fwupd.enable = true;

  services.tlp = {
    enable = true;
    settings = { USB_AUTOSUSPEND = 0; };
  };

  # For media keys, etc.
  services.acpid = { enable = true; };

  services.logind = {
    lidSwitch = "hybrid-sleep";
    lidSwitchDocked = "hybrid-sleep";
    lidSwitchExternalPower = "hybrid-sleep";
    extraConfig = ''
      HandlePowerKey=hybrid-sleep
      HandleSuspendKey=suspend
      HandleHibernateKey=hibernate
      IdleAction=ignore
    '';
  };
}
