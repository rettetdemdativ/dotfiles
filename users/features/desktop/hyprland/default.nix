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
  xdg.configFile."hypr/hyprland.conf".source = ../../../.config/hypr/hyprland.conf;
  xdg.configFile."hypr/apply_monitor_setup.sh".source =
    ../../../.config/hypr/apply_monitor_setup.sh;
  xdg.configFile."systemd/user/hyprland-session.target".source =
    ../../../.config/hypr/hyprland-session.target;

  home.packages = with pkgs; [ configure-gtk ];


  monitor_laptop = "sh $HOME/dotfiles/users/inet/features/desktop/hypr/apply_monitor_setup.sh laptop";
  monitor_home = "sh $HOME/dotfiles/users/inet/features/desktop/hypr/apply_monitor_setup.sh home";
  monitor_mirror = "sh $HOME/dotfiles/users/inet/features/desktop/hypr/apply_monitor_setup.sh mirror";
}
