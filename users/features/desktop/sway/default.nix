{ inputs, lib, config, pkgs, ... }:
let
  inherit (lib) getExe;
  swayCfg = config.wayland.windowManager.sway;
in {
  home.packages = with pkgs; [
    # Hyprland is imported through its flake in flake.nix
    seatd
    wdisplays
    grim
    slurp
    wl-clipboard
    cage # For running XWayland windows in separate "cage"

    numix-icon-theme
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = config.lib.nixGL.wrap (pkgs.sway.override {
      inherit (swayCfg) extraSessionCommands extraOptions;
      withBaseWrapper = swayCfg.wrapperFeatures.base;
      withGtkWrapper = swayCfg.wrapperFeatures.gtk;
    });
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
    extraConfig = ''
      # Author(s): Michael Koeppl
      # sway config file

      default_border none
      default_floating_border none

      for_window [title="\ -\ Sharing\ Indicator$"] floating enable, sticky enable

      set $mod Mod4

      # Set colors
      set $base00 #101218
      set $base01 #1f222d
      set $base02 #252936
      set $base03 #7780a1
      set $base03 #757575
      set $base04 #C0C5CE
      set $base05 #d1d4e0
      set $base06 #C9CCDB
      set $base07 #ffffff
      set $base08 #ee829f
      set $base09 #f99170
      set $base0A #ffefcc
      set $base0B #a5ffe1
      set $base0C #97e0ff
      set $base0D #97bbf7
      set $base0E #c0b7f9
      set $base0F #fcc09e

      set $darkred     #ff0000
      set $red         ##ff000
      set $darkgreen   #33ff00
      set $green       #33ff00
      set $darkyellow  #ff0099
      set $yellow      #ff0099
      set $darkblue    #0066ff
      set $blue        #0066ff
      set $darkmagenta #cc00ff
      set $magenta     #cc00ff
      set $darkcyan    #00ffff
      set $cyan        #00ffff
      set $darkwhite   #d0d0d0
      set $white       #ffffff
      # Use custom colors for black
      set $black       #282828
      set $darkblack   #1d2021
      set $transparent #00000000

      # Set workplace names
      set $workspace1 "1: "
      set $workspace2 "2: "
      set $workspace3 "3: "
      set $workspace4 "4: "
      set $workspace5 "5: "
      set $workspace6 "6: "
      set $workspace7 "7: "
      set $workspace8 "8: "
      set $workspace9 "9: "
      set $workspace10 "10: "


      #bar {
      #    swaybar_command waybar
      #}

      # This font is widely installed, provides lots of unicode glyphs, right-to-left
      # text rendering and scalability on retina/hidpi displays (thanks to pango).
      #font pango:DejaVu Sans Mono 8

      # Use Mouse+$mod to drag floating windows to their wanted position
      floating_modifier $mod

      # Bind certain applications to workspaces (get info about applications with xprop)
      #assign [app_id="firefox"] $workspace3

      # Disable idle for certain applications
      for_window [app_id="firefox"] inhibit_idle fullscreen
      for_window [app_id="librewolf"] inhibit_idle fullscreen
      for_window [app_id="^chromium$"] inhibit_idle fullscreen
      for_window [app_id="vlc"] inhibit_idle fullscreen
      for_window [app_id="mpv"] inhibit_idle fullscreen

      # ============================================================================================
      #                                         KEYBINDS
      # ============================================================================================

      # start a terminal
      #bindsym $mod+Return exec uxterm
      #bindsym $mod+Return exec ghostty
      #bindsym $mod+Return exec kitty
      #bindsym $mod+Return exec wezterm

      # kill focused window
      bindsym $mod+Shift+q kill

      # Screenshots
      bindsym $mod+Shift+s exec grim -g "$(slurp)" $HOME/Desktop/$(date +'%s_grim.png')

      # start rofi
      #bindsym $mod+d exec rofi -show

      #bindsym $mod+d exec fuzzel

      # change focus
      bindsym $mod+h focus left
      bindsym $mod+j focus down
      bindsym $mod+k focus up
      bindsym $mod+l focus right

      # alternatively, you can use the cursor keys:
      bindsym $mod+Left focus left
      bindsym $mod+Down focus down
      bindsym $mod+Up focus up
      bindsym $mod+Right focus right

      # move focused window
      bindsym $mod+Shift+h move left
      bindsym $mod+Shift+j move down
      bindsym $mod+Shift+k move up
      bindsym $mod+Shift+l move right

      # alternatively, you can use the cursor keys:
      bindsym $mod+Shift+Left move left
      bindsym $mod+Shift+Down move down
      bindsym $mod+Shift+Up move up
      bindsym $mod+Shift+Right move right

      # split in horizontal orientation
      bindsym $mod+Shift+v split h

      # split in vertical orientation
      bindsym $mod+v split v

      # enter fullscreen mode for the focused container
      bindsym $mod+f fullscreen toggle

      # change container layout (stacked, tabbed, toggle split)
      bindsym $mod+s layout stacking
      bindsym $mod+w layout tabbed
      bindsym $mod+e layout toggle split

      # toggle tiling / floating
      bindsym $mod+Shift+space floating toggle

      # change focus between tiling / floating windows
      bindsym $mod+space focus mode_toggle

      # focus the parent container
      bindsym $mod+a focus parent

      # switch to workspace
      bindsym $mod+1 workspace $workspace1
      bindsym $mod+2 workspace $workspace2
      bindsym $mod+3 workspace $workspace3
      bindsym $mod+4 workspace $workspace4
      bindsym $mod+5 workspace $workspace5
      bindsym $mod+6 workspace $workspace6
      bindsym $mod+7 workspace $workspace7
      bindsym $mod+8 workspace $workspace8
      bindsym $mod+9 workspace $workspace9
      bindsym $mod+0 workspace $workspace10

      # move focused container to workspace
      bindsym $mod+Shift+1 move container to workspace $workspace1
      bindsym $mod+Shift+2 move container to workspace $workspace2
      bindsym $mod+Shift+3 move container to workspace $workspace3
      bindsym $mod+Shift+4 move container to workspace $workspace4
      bindsym $mod+Shift+5 move container to workspace $workspace5
      bindsym $mod+Shift+6 move container to workspace $workspace6
      bindsym $mod+Shift+7 move container to workspace $workspace7
      bindsym $mod+Shift+8 move container to workspace $workspace8
      bindsym $mod+Shift+9 move container to workspace $workspace9
      bindsym $mod+Shift+0 move container to workspace $workspace10

      # PulseAudio controls
      #bindsym XF86AudioRaiseVolume exec pulseaudio-ctl up
      #bindsym XF86AudioLowerVolume exec pulseaudio-ctl down
      #bindsym XF86AudioMute exec pulseaudio-ctl mute

      # PipeWire controls
      bindsym XF86AudioRaiseVolume exec pamixer -i 5
      bindsym XF86AudioLowerVolume exec pamixer -d 5
      bindsym XF86AudioMute exec pamixer -t

      # Music controls
      bindsym XF86AudioPlay exec mpc toggle
      bindsym XF86AudioNext exec mpc next
      bindsym XF86AudioPrev exec mpc prev

      #bindsym XF86MonBrightnessUp exec xbacklight -inc 10 # increase screen brightness
      bindsym XF86MonBrightnessDown exec sudo brightnessctl set 5%- # decrease screen brightness
      #bindsym XF86MonBrightnessDown exec xbacklight -dec 10 # decrease screen brightness<Paste>
      bindsym XF86MonBrightnessUp exec sudo brightnessctl set 5%+ # increase screen brightness<Paste>

      # reload the configuration file
      bindsym $mod+Shift+c reload
      # exit sway
      bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'

      # resize window (you can also use the mouse for that)
      mode "resize" {
              # These bindings trigger as soon as you enter the resize mode

              # Pressing left will shrink the window’s width.
              # Pressing right will grow the window’s width.
              # Pressing up will shrink the window’s height.
              # Pressing down will grow the window’s height.
              #bindsym j resize shrink width 10 px or 10 ppt
              #bindsym k resize grow height 10 px or 10 ppt
              #bindsym l resize shrink height 10 px or 10 ppt
              #bindsym semicolon resize grow width 10 px or 10 ppt

              # same bindings, but for the arrow keys
              #bindsym Left resize shrink width 10 px or 10 ppt
              #bindsym Down resize grow height 10 px or 10 ppt
              #bindsym Up resize shrink height 10 px or 10 ppt
              #bindsym Right resize grow width 10 px or 10 ppt

              # back to normal: Enter or Escape
              #bindsym Return mode "default"
              #bindsym Escape mode "default"
      }

      bindsym $mod+r mode "resize"

      # ============================================================================================
      #                                      TILE MANAGEMENT
      # ============================================================================================

      #                       BORDER      BACKGROUND  TEXT        INDICATOR   CHILD_BORDER
      client.focused          $black      $black      $white      $darkblack  $darkblack
      client.unfocused        $black      $black      $black      $darkblack  $darkblack
      client.focused_inactive $black      $black      $white      $darkblack  $darkblack
      client.urgent           $darkred    $darkred    $black      $darkred    $darkred
      client.background $black

      gaps inner 12
      gaps outer 5

      #bindsym $mod+shift+x exec sh /home/inet/.i3/lock.sh
      bindsym $mod+shift+x exec swaylock -f -c 000000 --ring-color ffffff --clock
      bindsym $mod+alt+x exec oblogout

      ## PERSONAL STUFF ##
      focus_follows_mouse no
      hide_edge_borders --i3 smart
      titlebar_border_thickness 1 
      titlebar_padding 5 1

      input type:keyboard {
          xkb_layout us,de
          #xkb_options grp:rctrl_toggle
          xkb_options grp:alt_shift_toggle
      }
    '';

    config = {
      bars = [{ command = getExe pkgs.waybar; }];
      terminal = getExe (config.lib.nixGL.wrap pkgs.ghostty);
      menu = getExe (config.lib.nixGL.wrap pkgs.fuzzel);
      modifier = "Mod4";
      keybindings = let
        cfg = swayCfg.config;
        mod = cfg.modifier;
      in {
        "${mod}+Return" = "exec ${cfg.terminal}";
        "${mod}+d" = "exec ${cfg.menu}";
      };
    };
  };

  # services.swayidle = {
  #   enable = true;
  #   events = [{
  #     event = "before-sleep";
  #     command = getExe pkgs.swaylock-effects;
  #   }];
  #   timeouts = [
  #     {
  #       timeout = 300;
  #       command = getExe pkgs.swaylock-effects;
  #     }
  #     {
  #       timeout = 600;
  #       command = "${swaymsg} -- 'output * dpms off'";
  #       resumeCommand = "${swaymsg} -- 'output * dpms on'";
  #     }
  #   ];
  # };

  #programs.swaylock = {
  #  inherit (config.services.swayidle) enable;
  #  settings = {
  #    daemonize = true;
  #    ignore-empty-password = true;
  #    #image = "${pkgs.sway-background-image}/share/background.jpg";
  #    #scaling = "fill";
  #    show-keyboard-layout = true;
  #  };
  #};

  programs.waybar = { enable = true; };

  xdg.configFile."waybar/config".source = ../../../.config/waybar/config_sway;
  xdg.configFile."waybar/style.css".source = ../../../.config/waybar/style.css;

}
