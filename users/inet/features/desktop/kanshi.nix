{ inputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [
    kanshi
  ];

  services.kanshi = {
    enable = false;
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
            criteria = "DP-2";
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
            criteria = "DP-1";
            status = "enable";
          }
        ];
      };
    };
  };
}
