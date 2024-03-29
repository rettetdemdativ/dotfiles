{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./kanshi.nix
    ./gammastep.nix
    ./waybar.nix
    ./mako.nix
    ./zathura.nix
  ];

  programs.zsh = {
    initExtraFirst = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_DESKTOP=hyprland
        export _JAVA_AWT_WM_NONREPARENTING=1
        export MOZ_ENABLE_WAYLAND=1
        export MOZ_WEBRENDER=1
        exec Hyprland
      fi	
    '';
  };

  home.packages = with pkgs; [
    # Hyprland is imported through its flake in flake.nix
    seatd
    hyprpaper
    swaylock-effects
    swayidle
    wdisplays
    bemenu
    grim
    slurp
    wl-clipboard

    numix-icon-theme
  ];
}
