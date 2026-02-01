{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.8;
          }
        ];
      };

      dockedHome1 = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-7";
            status = "enable";
          }
        ];
      };
      dockedHome2 = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-8";
            status = "enable";
          }
        ];
      };
    };
  };
}
