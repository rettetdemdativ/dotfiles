{ inputs, config, pkgs, username, ... }: {
  home.persistence."/persist/home/${username}" = {
    directories = [ ".config/VSCodium" ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = [
        pkgs.vscode-extensions.vscodevim.vim
        pkgs.vscode-extensions.pkief.material-icon-theme
        pkgs.vscode-extensions.vscode-icons-team.vscode-icons
        pkgs.vscode-extensions.dbaeumer.vscode-eslint
        pkgs.vscode-extensions.eamodio.gitlens
        pkgs.vscode-extensions.esbenp.prettier-vscode
        pkgs.vscode-extensions.ms-python.python
        pkgs.vscode-extensions.ms-python.black-formatter
        pkgs.vscode-extensions.ms-python.debugpy
        #pkgs.vscode-extensions.ms-toolsai.jupyter
        #pkgs.vscode-extensions.ms-toolsai.jupyter-renderers
        pkgs.vscode-extensions.redhat.java
        pkgs.vscode-extensions.hashicorp.terraform
        pkgs.vscode-extensions.golang.go
        pkgs.vscode-extensions.svelte.svelte-vscode
        pkgs.vscode-extensions.ms-vscode.cpptools
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.editorconfig.editorconfig
        pkgs.vscode-extensions.rust-lang.rust-analyzer
        #pkgs.vscode-extensions.vadimcn.vscode-lldb
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "fleet-theme";
          publisher = "MichaelZhou";
          version = "1.3.10";
          sha256 = "sha256-zQBziXtu9OiCAR/XMt73DY7CE/KJxtEAHoAi7rJp8hQ=";
        }
        {
          name = "ng-template";
          publisher = "Angular";
          version = "19.0.4";
          sha256 = "sha256-ERsbEtx/PaVCky0TWWlBNqSIyTDwVKpYaZtYaSqQw9g=";
        }
      ];
      userSettings = {
        "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[json]"."editor.defaultFormatter" = "vscode.json-language-features";
        "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
        "[svelte]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescriptreact]"."editor.defaultFormatter" =
          "esbenp.prettier-vscode";
        "[vue]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "breadcrumbs.enabled" = true;
        "debug.console.fontSize" = 15;
        "editor.bracketPairColorization.enabled" = true;
        "editor.codeActionsOnSave" = {
          "source.addMissingImports" = "explicit";
          "source.fixAll.eslint" = "explicit";
          "source.organizeImports" = "explicit";
        };
        "editor.fontFamily" = "Iosevka NF";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 15;
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
        "gitlens.plusFeatures.enabled" = false;
        "gitlens.launchpad.indicator.enabled" = false;
        "go.formatTool" = "goimports";
        "go.useLanguageServer" = true;
        "nix.formatterPath" = "/etc/profiles/per-user/${username}/bin/nixfmt";
        "svelte.enable-ts-plugin" = true;
        "terminal.integrated.fontSize" = 15;
        "vim.easymotion" = true;
        "vim.handleKeys" = { "<C-p>" = false; };
        "window.commandCenter" = true;
        "window.menuBarVisibility" = "toggle";
        "workbench.activityBar.location" = "hidden";
        "workbench.editor.tabSizing" = "shrink";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.sideBar.location" = "left";
        "workbench.statusBar.visible" = true;
      };
    };
  };
}
