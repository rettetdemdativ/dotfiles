{ lib, config, pkgs, ... }:

{
  # In addition to niri as a default, nixbox also has GNOME
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

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

  # Enable lact as well
  environment.systemPackages = with pkgs; [ lact mangohud ];

  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    enable = true;
    serviceConfig = { ExecStart = "${pkgs.lact}/bin/lact daemon"; };
    wantedBy = [ "multi-user.target" ];
  };
}
