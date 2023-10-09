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
      pkgs.vscode-extensions.golang.go
      pkgs.vscode-extensions.editorconfig.editorconfig
      pkgs.vscode-extensions.rust-lang.rust-analyzer
    ];
    userSettings = {
      "window.menuBarVisibility" = "toggle";
      "window.commandCenter" = true;

      "vim.easymotion" = true;

      "workbench.iconTheme"= "vscode-icons";
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
      "terminal.integrated.fontSize" = 13;
      "terminal.integrated.fontWeightBold" = "normal";
      "debug.console.fontSize" = 13;

      "go.formatTool" = "goimports";
      "go.useLanguageServer" = true;
    };
  };
}
