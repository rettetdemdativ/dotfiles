{ inputs, lib, config, pkgs, ... }: {

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "swaylock -f --screenshots --clock --indicator --effect-blur 7x5 --grace 2 --fade-in 0.2"; }
    ];
    timeouts = [
      { timeout = 300; command = "swaylock -f --screenshots --clock --indicator --effect-blur 7x5 --grace 2 --fade-in 0.2"; }
      { timeout = 600; command = "niri msg action power-off-monitors"; resumeCommand = "niri msg action power-off-monitors"; }
    ];
  };
}
