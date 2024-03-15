{ inputs, lib, config, pkgs, ... }:
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
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Adwaita-dark'
      gsettings set $gnome_schema icon-theme 'Numix'
      gsettings set $gnome_schema color-scheme 'prefer-dark'
    '';
  };
in {
  xdg.configFile."niri/config.kdl".source = ../../.config/niri/config.kdl;

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

  home.packages = with pkgs; [ configure-gtk ];
}
