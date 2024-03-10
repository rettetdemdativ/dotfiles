{ inputs, lib, config, pkgs, ... }: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Monaspace Neon";
        icons-enabled = false;
      };
      colors = {
        background = "00000000";
        text = "ffffffff";
        match = "cb4b16ff";
      };
      dmenu = { mode = "text"; };
    };
  };
}
