{ inputs, config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.vscodevim.vim
      pkgs.vscode-extensions.vscode-icons-team.vscode-icons
      pkgs.vscode-extensions.dbaeumer.vscode-eslint
      pkgs.vscode-extensions.eamodio.gitlens
      pkgs.vscode-extensions.esbenp.prettier-vscode
      pkgs.vscode-extensions.ms-python.python
      pkgs.vscode-extensions.ms-python.black-formatter
      pkgs.vscode-extensions.golang.go
      pkgs.vscode-extensions.svelte.svelte-vscode
      pkgs.vscode-extensions.angular.ng-template
      pkgs.vscode-extensions.ms-vscode.cpptools
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.editorconfig.editorconfig
      pkgs.vscode-extensions.rust-lang.rust-analyzer
    ];
    userSettings = {
      "window.menuBarVisibility" = "toggle";
      "window.commandCenter" = true;

      "vim.easymotion" = true;

      "workbench.iconTheme" = "vscode-icons";
      "workbench.activityBar.visible" = false;
      "workbench.statusBar.visible" = true;
      "workbench.editor.tabSizing" = "shrink";
      "workbench.sideBar.location" = "right";
      "breadcrumbs.enabled" = true;
      "editor.fontFamily" = "JetBrains Mono";
      "editor.fontSize" = 15;
      "editor.fontLigatures" = true;
      "editor.renderControlCharacters" = false;
      "editor.renderWhitespace" = "selection";
      "editor.lineNumbers" = "relative";
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = "active";
      "editor.guides.indentation" = false;
      "editor.suggestSelection" = "first";
      "editor.minimap.enabled" = false;
      "editor.minimap.side" = "left";
      "editor.formatOnSave" = true;
      "editor.codeActionsOnSave" = {
        "source.addMissingImports" = true;
        "source.organizeImports" = true;
        "source.fixAll.eslint" = true;
      };
      "terminal.integrated.fontSize" = 15;
      "debug.console.fontSize" = 15;

      "go.formatTool" = "goimports";
      "go.useLanguageServer" = true;

      "svelte.enable-ts-plugin" = true;

      "nix.formatterPath" = "/etc/profiles/per-user/inet/bin/nixfmt";

      "files.exclude" = {
        "**/__pycache__" = true;
        "**/.classpath" = true;
        "**/.project" = true;
        "**/.settings" = true;
        "**/.factorypath" = true;
      };

      "[vue]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[json]"."editor.defaultFormatter" = "vscode.json-language-features";
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[svelte]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
    };
  };
}
