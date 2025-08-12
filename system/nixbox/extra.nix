{ lib, config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "steam" "steam-unwrapped" ];
    packageOverrides = let
      curlWithGnuTls = (pkgs.curl.override {
        gnutlsSupport = true;
        opensslSupport = false;
      });
    in pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [ curlWithGnuTls curlWithGnuTls.out ];
      };
    };
  };

  # In addition to niri as a default, nixbox also has GNOME
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    cheese
    gnome-terminal
    epiphany
    geary
    evince
    totem
    gnome-photos
    gnome-tour
    gnome-music
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  services.logind = {
    extraConfig = ''
      HandlePowerKey=hybrid-sleep
      HandleSuspendKey=suspend
      HandleHibernateKey=hibernate
      IdleAction=ignore
    '';
  };

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers

    protontricks.enable = true;
    gamescopeSession.enable = true;

    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    extraPackages = with pkgs; [ mangohud ];
  };

  # systemd.tmpfiles.rules = let
  #   rocmEnv = pkgs.symlinkJoin {
  #     name = "rocm-combined";
  #     paths = with pkgs.rocmPackages; [ rocblas hipblas clr ];
  #   };
  # in [ "L+    /opt/rocm   -    -    -     -    ${rocmEnv}" ];

  # Enable lact as well
  environment.systemPackages = with pkgs; [ lact mangohud ];

  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    enable = true;
    serviceConfig = { ExecStart = "${pkgs.lact}/bin/lact daemon"; };
    wantedBy = [ "multi-user.target" ];
  };

  # Set limits for esync.
  systemd.settings.Manager = { DefaultLimitNOFILE = 1048576; };

  security.pam.loginLimits = [{
    domain = "*";
    type = "hard";
    item = "nofile";
    value = "1048576";
  }];
}
