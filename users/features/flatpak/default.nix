{ inputs, lib, config, pkgs, username, flake-inputs, ... }: {
  imports = [ flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  services.flatpak = {
    overrides = {
      global = {
        # Force Wayland by default
        #Context.sockets = [ "wayland" "!x11" "!fallback-x11" ];

        Environment = {
          # Fix un-themed cursor in some Wayland apps
          #XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

          # Force correct theme for some GTK apps
          GTK_THEME = "Adwaita:dark";
        };
      };

      "com.valvesoftware.Steam".Context = {
        filesystems = [
          "xdg-config/git:ro" # Expose user Git config
          "/run/current-system/sw/bin:ro" # Expose NixOS managed software
          "/home/${username}/.local/share/Steam"
        ];
      };

    };

    packages = [{
      appId = "com.valvesoftware.Steam";
      origin = "flathub";
    }];
  };
}
