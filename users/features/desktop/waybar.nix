{ inputs, lib, config, pkgs, ... }: {
  systemd.user.services.waybar = {
    Unit = {
      Description = "waybar service";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
    };
  };
}
