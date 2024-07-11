{ lib, config, pkgs, ... }:

{
  systemd.services.nix-daemon.serviceConfig.LimitNOFILE = lib.mkForce 40960;

  # In addition to niri as a default, nixbox also has GNOME
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

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
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
}
