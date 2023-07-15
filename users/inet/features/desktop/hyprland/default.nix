{ inputs, lib, config, pkgs, ... }: {
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
    waybar
    mako
    hyprpaper
    bemenu
  ];

  wayland.windowManager.hyprland.enable = true;
  xdg.configFile."../../../.config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;

  programs.waybar.enable = true;
  xdg.configFile."../../../.config/waybar/config".source = ./config/waybar/config;
  xdg.configFile."../../../.config/waybar/style.css".source = ./config/waybar/style.css;

  xdg.configFile."../../../.config/mako/config".source = ./config/mako/config;
}
