{ inputs, lib, config, pkgs, username, ... }:
let
in {
  xdg.configFile."niri/config.kdl".source = ../../../.config/niri/config.kdl;

  # Services started with niri
  xdg.configFile."systemd/user/niri.service.wants/swayidle.service".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.xdg.configHome}/systemd/user/swayidle.service";
  xdg.configFile."systemd/user/niri.service.wants/swaybg.service".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.xdg.configHome}/systemd/user/swaybg.service";
  xdg.configFile."systemd/user/niri.service.wants/waybar.service".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.xdg.configHome}/systemd/user/waybar.service";

  #programs.zsh = {
  #  enable = true;
  #  initContent = lib.mkBefore ''
  #    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  #      export QT_QPA_PLATFORM=wayland
  #      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  #      export XDG_SESSION_TYPE=wayland
  #      #export XDG_CURRENT_DESKTOP=hyprland
  #      export _JAVA_AWT_WM_NONREPARENTING=1
  #      export MOZ_ENABLE_WAYLAND=1
  #      export MOZ_WEBRENDER=1
  #      #exec dbus-run-session niri-session
  #      exec niri-session
  #    fi
  #  '';
  #};
}
