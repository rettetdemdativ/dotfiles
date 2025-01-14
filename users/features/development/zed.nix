{ inputs, config, pkgs, ... }:
let
  zed-fhs = pkgs.buildFHSEnv {
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
      #"pylsp"
      "ruff"
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
      buffer_font_family = "Iosevka NF";
      ui_font_size = 16;
      buffer_font_size = 15;
      theme = {
        mode = "dark";
        light = "Fleet Dark";
        dark = "Fleet Dark";
      };

      experimental.theme_overrides = {
        syntax = { comment = { font_style = "italic"; }; };
      };
      project_panel = { dock = "right"; };
      outline_panel = { dock = "right"; };
      collaboration_panel = { dock = "right"; };
      tabs = {
        file_icons = true;
        git_status = true;
      };
      relative_line_numbers = true;
      #server_url = "https://disable-zed-downloads.invalid";
      indent_guides = { enabled = false; };

      lsp = {
        rust-analyzer = { binary = { path_lookup = true; }; };
        clangd = {
          binary = {
            path_lookup = true;
            #path = "clangd";
            arguments = ["--background-index" "--compile-commands-dir=build"];
          };
        };
        nix = { binary = { path_lookup = true; }; };
        #nil.formatting.command = "nixfmt";
        pyright = {
          settings = { python = { pythonPath = "./venv/bin/python"; }; };
        };
      };
      languages = {
        "C" = {
          format_on_save = "on";
          tab_size = 4;
        };
        "C++" = {
          format_on_save = "on";
          tab_size = 4;
        };
        "JavaScript" = {
          formatter = {
            external = {
              command = "prettierd";
              arguments = [ "--stdin-filepath" "{buffer_path}" ];
            };
          };
          language_servers = [ "typescript-language-server" "!vtsls" ];
        };
        "Markdown" = { format_on_save = "on"; };
        "Python" = {
          language_servers = [ "pyright" "ruff" ];
          format_on_save = "on";
          formatter = [{ language_server = { name = "ruff"; }; }];
        };
        "TSX" = {
          language_servers = [ "typescript-language-server" "!vtsls" ];

          formatter = {
            external = {
              command = "prettierd";
              arguments = [ "--stdin-filepath" "{buffer_path}" ];
            };
          };

        };
        "TypeScript" = {
          language_servers = [ "typescript-language-server" "!vtsls" ];
          formatter = {
            external = {
              command = "prettierd";
              arguments = [ "--stdin-filepath" "{buffer_path}" ];
            };
          };

        };
      };
      load_direnv = "shell_hook";
    };
  };
}
