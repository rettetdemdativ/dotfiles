{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{

  services.swayidle =
    let
      lock = "${pkgs.swaylock-effects}/bin/swaylock -f --screenshots --clock --indicator --effect-blur 7x5 --grace 5 --fade-in 0.2";
      display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
    in
    {
      enable = true;
      events = {
        before-sleep = (display "off") + "; " + lock;
        after-resume = display "on";
      };
      timeouts = [
        {
          timeout = 600;
          command = lock;
        }
        {
          timeout = 900;
          command = display "off";
        }
      ];
    };
}
