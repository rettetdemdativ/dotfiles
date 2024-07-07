{ wpPath }:
{ inputs, lib, config, pkgs, ... }: {

  home.packages = with pkgs; [ swaybg findutils coreutils ];

  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg service";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Install = { WantedBy = [ "default.target" ]; };
    Service = {
      ExecStart = let
        script = pkgs.writeScript "swaybg-start" ''
          #!${pkgs.runtimeShell}
          path="$1"
          ${pkgs.swaybg}/bin/swaybg -i $(${pkgs.findutils}/bin/find "$path" -type f | ${pkgs.coreutils}/bin/shuf -n1);
        '';
      in "${script} ${wpPath}";
    };
  };
}
