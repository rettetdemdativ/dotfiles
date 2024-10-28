{ inputs, config, pkgs, ... }:
let
  zed-fhs = pkgs.buildFHSUserEnv {
    name = "zed";
    targetPkgs = pkgs: with pkgs; [ zed-editor ];
    runScript = "zeditor";
  };

in {
  programs.zed-editor = {
    enable = true;
    package = zed-fhs;
    extensions = [
      "basher"
      "docker-compose"
      "dockerfile"
      "fleet-themes"
      "github-theme"
      "intellij-newui-theme"
      "material-dark"
      "material-theme"
      "nightfox"
      "nix"
      "pylsp"
      "scss"
      "sql"
      "tokyo-night"
      "typst"
      "vscode-dark-modern"
      "vscode-dark-plus"
      "xcode-themes"
    ];
    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = true;
      buffer_font_family = "JetBrains Mono";
      ui_font_size = 16;
      buffer_font_size = 14.5;
      theme = {
        mode = "dark";
        light = "Fleet Dark";
        dark = "Fleet Dark";
      };
      experimental.theme_overrides = {
        syntax = { comment = { font_style = "italic"; }; };
      };
      tabs = {
        file_icons = true;
        git_status = true;
      };
      relative_line_numbers = true;
      #server_url = "https://disable-zed-downloads.invalid";
    };
  };
}
