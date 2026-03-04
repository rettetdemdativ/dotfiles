{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) getExe mkOptionDefault;
  swayCfg = config.wayland.windowManager.sway;
in
{
  imports = [
    ../kanshi.nix
    ../swayidle_sway.nix
    ../wmenu.nix
  ];

  home.packages = with pkgs; [
    waybar
  ];

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = true;
    wrapperFeatures.gtk = true;
    systemd.enable = true;

    extraSessionCommands = ''
      export CLUTTER_BACKEND=wayland
      export ECORE_EVAS_ENGINE=wayland-egl
      export ELM_ENGINE=wayland_egl
      export MOZ_ENABLE_WAYLAND=1
      export NIXOS_OZONE_WL=1
      export NO_AT_BRIDGE=1
      export QT_QPA_PLATFORM=wayland-egl
      export SDL_VIDEODRIVER=wayland
      export XDG_CURRENT_DESKTOP=sway
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';

    config = {
      modifier = "Mod4";
      terminal = getExe (config.lib.nixGL.wrap pkgs.alacritty);
      menu = "${pkgs.wmenu}/bin/wmenu-run";

      bars = [ { command = getExe pkgs.waybar; } ];

      fonts = {
        names = [ "Monaspace Neon NF" ];
        size = 9.0;
      };

      focus = {
        followMouse = "no";
      };

      input = {
        "type:keyboard" = {
          xkb_layout = "us,de";
          xkb_options = "grp:alt_shift_toggle";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };

      #colors = {
      #  background = "#282828"; # $black
      #  focused = {
      #    border = "#282828"; # $black
      #    background = "#282828"; # $black
      #    text = "#ffffff"; # $white
      #    indicator = "#1d2021"; # $darkblack
      #    childBorder = "#1d2021"; # $darkblack
      #  };
      #  unfocused = {
      #    border = "#282828"; # $black
      #    background = "#282828"; # $black
      #    text = "#282828"; # $black
      #    indicator = "#1d2021"; # $darkblack
      #    childBorder = "#1d2021"; # $darkblack
      #  };
      #  focusedInactive = {
      #    border = "#282828"; # $black
      #    background = "#282828"; # $black
      #    text = "#ffffff"; # $white
      #    indicator = "#1d2021"; # $darkblack
      #    childBorder = "#1d2021"; # $darkblack
      #  };
      #  urgent = {
      #    border = "#ff0000"; # $darkred
      #    background = "#ff0000"; # $darkred
      #    text = "#282828"; # $black
      #    indicator = "#ff0000"; # $darkred
      #    childBorder = "#ff0000"; # $darkred
      #  };
      #};

      window = {
        border = 2;
        titlebar = true;

        commands = [
          {
            command = "floating enable, sticky enable";
            criteria = {
              title = "\\ -\\ Sharing\\ Indicator$";
            };
          }
          {
            command = "inhibit_idle fullscreen";
            criteria = {
              app_id = "firefox";
            };
          }
          {
            command = "inhibit_idle fullscreen";
            criteria = {
              app_id = "librewolf";
            };
          }
          {
            command = "inhibit_idle fullscreen";
            criteria = {
              app_id = "^chromium$";
            };
          }
          {
            command = "inhibit_idle fullscreen";
            criteria = {
              app_id = "vlc";
            };
          }
          {
            command = "inhibit_idle fullscreen";
            criteria = {
              app_id = "mpv";
            };
          }
        ];
      };

      floating = {
        border = 2;
        titlebar = true;
      };

      modes = {
        resize = {
          Down = "resize grow height 10 px";
          Escape = "mode default";
          Left = "resize shrink width 10 px";
          Return = "mode default";
          Right = "resize grow width 10 px";
          Up = "resize shrink height 10 px";
          h = "resize shrink width 100 px";
          j = "resize grow height 50 px";
          k = "resize shrink height 50 px";
          l = "resize grow width 100 px";
        };
      };

      keybindings =
        let
          mod = swayCfg.config.modifier;
        in
        mkOptionDefault {
          "${mod}+Return" = "exec ${swayCfg.config.terminal}";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec ${swayCfg.config.menu}";

          "${mod}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+Shift+v" = "split h";
          "${mod}+v" = "split v";

          "${mod}+f" = "fullscreen toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          "XF86AudioRaiseVolume" = "exec pamixer -i 5";
          "XF86AudioLowerVolume" = "exec pamixer -d 5";
          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioPlay" = "exec mpc toggle";
          "XF86AudioNext" = "exec mpc next";
          "XF86AudioPrev" = "exec mpc prev";

          "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

          "${mod}+r" = "mode resize";
          "${mod}+Shift+x" =
            "exec swaylock -f --screenshots --clock --indicator --effect-blur 7x5 --fade-in 0.2";
          "${mod}+Mod1+x" = "exec oblogout";
        };
    };

    extraConfig = ''
      titlebar_padding 5 2

      # Optional leftover config that couldn't map cleanly or are purely decorative:
      # default_border none
      # default_floating_border none
      # gaps inner 12
      # gaps outer 5
      # hide_edge_borders --i3 smart
      # titlebar_border_thickness 1
      # titlebar_padding 5 1
    '';
  };

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
        export _JAVA_AWT_WM_NONREPARENTING=1
        export MOZ_ENABLE_WAYLAND=1
        export MOZ_WEBRENDER=1
        exec sway
      fi
    '';
  };

  # Waybar config is different for sway than for niri, etc.
  xdg.configFile."waybar/config".source = ../../../.config/waybar/sway/config;
  xdg.configFile."waybar/style.css".source = ../../../.config/waybar/sway/style.css;
}
