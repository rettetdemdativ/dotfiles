{ wpPath } : { inputs, lib, config, pkgs, ... }: {

  home.packages = with pkgs; [
    swaybg
  ];

  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg service";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i \"${wpPath}\"";
    };
  };
}
