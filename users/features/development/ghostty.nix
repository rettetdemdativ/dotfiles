{ inputs, lib, config, pkgs, username, ... }: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrains Mono";
      font-size = 12;
      #font-style = "Medium";
      #font-style-bold = "Bold";
      #font-style-italic = "Medium Italic";
      #font-style-bold-italic = "Bold Italic";

      theme = "Monokai Remastered";
      #theme = "Dark Pastel"
      window-decoration = false;

      window-padding-y = "2,1";
      window-inherit-working-directory = true;

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
