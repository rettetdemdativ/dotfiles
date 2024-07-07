{ inputs, lib, config, pkgs, ... }: {
  #programs.waybar = {
  #  enable = true;
  #  systemd.enable = true;
  #};

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

  xdg.configFile."waybar/config".source = ../../.config/waybar/config;
  xdg.configFile."waybar/style.css".source = ../../.config/waybar/style.css;
}
