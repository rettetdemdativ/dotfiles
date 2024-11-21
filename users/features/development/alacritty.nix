{ inputs, lib, config, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 11.5;
        normal = { family = "JetBrains Mono"; };
      };
      window.padding = {
        x = 8;
        y = 8;
      };
      window.opacity = 0.95;
      colors = {
        draw_bold_text_with_bright_colors = true;
        primary = {
          background = "0x000000";
          foreground = "0xffffff";
        };
        cursor = {
          text = "0xF81CE5";
          cursor = "0xffffff";
        };

        normal = {
          black = "0x000000";
          red = "0xfe0100";
          green = "0x33ff00";
          yellow = "0xfeff00";
          blue = "0x0066ff";
          magenta = "0xcc00ff";
          cyan = "0x00ffff";
          white = "0xd0d0d0";
        };

        # Bright colors
        bright = {
          black = "0x808080";
          red = "0xfe0100";
          green = "0x33ff00";
          yellow = "0xfeff00";
          blue = "0x0066ff";
          magenta = "0xcc00ff";
          cyan = "0x00ffff";
          white = "0xFFFFFF";
        };
      };
      keyboard = {
        bindings = [{
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }];
      };
    };
  };
}
