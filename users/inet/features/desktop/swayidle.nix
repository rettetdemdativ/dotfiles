{ inputs, lib, config, pkgs, ... }: {

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f --screenshots --clock --indicator --effect-blur 7x5 --grace 5 --fade-in 0.2"; }
    ];
    timeouts = [
      { timeout = 600; command = "${pkgs.swaylock-effects}/bin/swaylock -f --screenshots --clock --indicator --effect-blur 7x5 --grace 5 --fade-in 0.2"; }
      { timeout = 900; command = "${pkgs.niri}/bin/niri msg action power-off-monitors"; resumeCommand = "niri msg action power-off-monitors"; }
    ];
  };
}
