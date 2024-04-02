{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./fuzzel.nix
    ./gammastep.nix
    #./hyprland.nix
    ./hyprpaper.nix
    ./kanshi.nix
    ./mako.nix
    ./niri.nix
    (import ./swaybg.nix { wpPath = "/home/inet/Pictures/Wallpapers/dctower.jpg"; })
    ./swayidle.nix
    ./waybar.nix
    ./zathura.nix
  ];

  programs.zsh = {
    initExtraFirst = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export XDG_SESSION_TYPE=wayland
        #export XDG_CURRENT_DESKTOP=hyprland
        export _JAVA_AWT_WM_NONREPARENTING=1
        export MOZ_ENABLE_WAYLAND=1
        export MOZ_WEBRENDER=1
        #exec dbus-run-session niri-session
        exec niri-session
      fi	
    '';
  };


  home.packages = with pkgs; [
    # Hyprland is imported through its flake in flake.nix
    seatd
    swaylock-effects
    wdisplays
    grim
    slurp
    wl-clipboard
    cage # For running XWayland windows in separate "cage"

    numix-icon-theme
  ];
}
