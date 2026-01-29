{ inputs, lib, config, pkgs, ... }: {
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    profiles = {
      undocked = {
        outputs = [{
          criteria = "eDP-1";
          status = "enable";
        }];
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
    };
  };
}
