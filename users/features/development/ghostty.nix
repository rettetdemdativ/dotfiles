{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    systemd.enable = true;
    settings = {
      font-family = "JetBrains Mono";
      font-size = 11.5;

      theme = "Monokai Remastered";
      #theme = "Dark Pastel"
      window-decoration = false;

      window-padding-y = "2,1";
      window-inherit-working-directory = true;

      gtk-single-instance = false;

      keybind = [
        "ctrl+shift+n=new_window"
        "ctrl+t=new_tab"
        "alt+left=next_tab"
        "alt+right=previous_tab"
        "alt+d=toggle_window_decorations"
      ];
    };
  };
}
