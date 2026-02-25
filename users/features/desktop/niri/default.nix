{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Adwaita-dark'
        gsettings set $gnome_schema icon-theme 'Numix'
        gsettings set $gnome_schema color-scheme 'prefer-dark'
      '';
  };
in
{
  imports = [
    ../swayidle_niri.nix
    ../waybar.nix
    (import ./swaybg.nix { wpPath = "/home/${username}/Pictures/Wallpapers"; })
  ];

  xdg.configFile."niri/config.kdl".source = ../../../.config/niri/config.kdl;

  # Services started with niri
  xdg.configFile."systemd/user/niri.service.wants/swayidle.service".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/systemd/user/swayidle.service";
  xdg.configFile."systemd/user/niri.service.wants/swaybg.service".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/systemd/user/swaybg.service";
  xdg.configFile."systemd/user/niri.service.wants/waybar.service".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/systemd/user/waybar.service";

  # Waybar config is different for niri than for sway, etc.
  xdg.configFile."waybar/config".source = ../../../.config/waybar/niri/config;
  xdg.configFile."waybar/style.css".source = ../../../.config/waybar/niri/style.css;

  home.packages = with pkgs; [ configure-gtk ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      monitor_home = "sh $HOME/dotfiles/users/features/desktop/niri/scripts/monitors.sh home";
      monitor_laptop = "sh $HOME/dotfiles/users/features/desktop/niri/scripts/monitors.sh laptop";
    };
    initContent = lib.mkBefore ''
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
}
