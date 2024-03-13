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
      pkgs.vscode-extensions.ms-toolsai.jupyter
      pkgs.vscode-extensions.ms-toolsai.jupyter-renderers
      pkgs.vscode-extensions.hashicorp.terraform
      pkgs.vscode-extensions.golang.go
      pkgs.vscode-extensions.svelte.svelte-vscode
      pkgs.vscode-extensions.angular.ng-template
      pkgs.vscode-extensions.ms-vscode.cpptools
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.editorconfig.editorconfig
      pkgs.vscode-extensions.rust-lang.rust-analyzer
      pkgs.vscode-extensions.vadimcn.vscode-lldb
    ];
    userSettings = {
      "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[json]"."editor.defaultFormatter" = "vscode.json-language-features";
      "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
      "[svelte]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[vue]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "breadcrumbs.enabled" = true;
      "debug.console.fontSize" = 15;
      "editor.bracketPairColorization.enabled" = true;
        "editor.codeActionsOnSave" = {
        "source.addMissingImports" = "explicit";
        "source.fixAll.eslint" = "explicit";
        "source.organizeImports" = "explicit";
      };
      "editor.fontFamily" = "Monaspace Neon";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 15.5;
      "editor.formatOnSave" = false;
      "editor.guides.bracketPairs" = "active";
      "editor.guides.indentation" = false;
      "editor.lineNumbers" = "relative";
      "editor.minimap.enabled" = false;
      "editor.minimap.side" = "left";
      "editor.renderControlCharacters" = false;
      "editor.renderWhitespace" = "selection";
      "editor.suggestSelection" = "first";
      "files.exclude" = {
        "**/.classpath" = true;
        "**/.factorypath" = true;
        "**/.project" = true;
        "**/.settings" = true;
        "**/__pycache__" = true;
      };
      "go.formatTool" = "goimports";
      "go.useLanguageServer" = true;
      "nix.formatterPath" = "/etc/profiles/per-user/inet/bin/nixfmt";
      "svelte.enable-ts-plugin" = true;
      "terminal.integrated.fontSize" = 15;
      "vim.easymotion" = true;
      "window.commandCenter" = true;
      "window.menuBarVisibility" = "toggle";
      "workbench.activityBar.location" = "hidden";
      "workbench.editor.tabSizing" = "shrink";
      "workbench.iconTheme" = "vscode-icons";
      "workbench.sideBar.location" = "right";
      "workbench.statusBar.visible" = true;
    };
  };
}
