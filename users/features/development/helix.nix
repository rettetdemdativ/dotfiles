{ inputs, config, pkgs, ... }: {
  programs.helix = {
    enable = true;
    extraPackages = [
      pkgs.gopls
      pkgs.rust-analyzer
      pkgs.nil
      pkgs.nixfmt-classic
      pkgs.python311Packages.python-lsp-server
      pkgs.dockerfile-language-server-nodejs
      pkgs.docker-compose-language-service
    ];
    settings = {
      theme = "gruvbox";
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

        file-picker = {
          hidden = false;
        };
      };
    };
  };
}
