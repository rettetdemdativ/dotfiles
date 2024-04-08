{ inputs, config, pkgs, ... }: {
  programs.helix = {
    enable = true;
    extraPackages = [ pkgs.gopls pkgs.nil pkgs.nixfmt ];
    settings = {
      theme = "dark_plus";
      editor = {
        line-number = "relative";
        color-modes = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          left = [ "mode" "spinner" "file-name" ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
          ];
          separator = "|";
        };
      };
    };
  };
}
