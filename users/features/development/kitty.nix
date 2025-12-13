{ inputs, lib, config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    keybindings = { "ctrl+shift+enter" = "new_os_window_with_cwd"; };
    extraConfig = ''
      linux_display_server wayland

      font_family JetBrainsMono Nerd Font Mono
      bold_font auto
      italic_font auto
      bold_italic_font auto

      font_size 12

      cursor_shape block
      shell_integration no-cursor

      enable_audio_bell no

      tab_bar_style powerline

      color0  #000000
      color8  #808080

      color1  #ff0000
      color9  #ff0000

      color2  #33ff00
      color10 #33ff00

      color3  #ff0099
      color11 #ff0099

      color4  #0066ff
      color12 #0066ff

      color5  #cc00ff
      color13 #cc00ff

      color6  #00ffff
      color14 #00ffff

      color7  #d0d0d0
      color15 #ffffff
    '';
  };
}
