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
      pkgs.vscode-extensions.golang.go
      pkgs.vscode-extensions.svelte.svelte-vscode
      pkgs.vscode-extensions.angular.ng-template
      pkgs.vscode-extensions.ms-vscode.cpptools
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.editorconfig.editorconfig
      pkgs.vscode-extensions.rust-lang.rust-analyzer
    ] ++ [
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "csharp";
          publisher = "ms-dotnettools";
          version = "2.19.13";
          sha256 = "sha256-0SkAo93ahCMbWSo6CrnRN6fzKrqMkFURmuBjIqnxh9s=";
        };
      })
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "vscode-dotnet-runtime";
          publisher = "ms-dotnettools";
          version = "2.0.0";
          sha256 = "sha256-oTeVskg9yfohlBW4GhgQj3TsweUoZ6WuxmntsispxOo=";
        };
        postPatch = ''
          chmod +x "$PWD/dist/install scripts/dotnet-install.sh"
        '';
      })

      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "csdevkit";
          publisher = "ms-dotnettools";
          version = "1.3.4";
          sha256 = "sha256-36lL754/kRwlnMXRiiTvHM80oWPR3MW5GBUCdHpefFc=";
          arch = "linux-x64";
        };

        sourceRoot = "./extension";

        postPatch = with pkgs; ''
          patchelf_add_icu_as_needed() {
            declare elf="''${1?}"
            declare icu_major_v="${
              lib.head (lib.splitVersion (lib.getVersion icu.name))
            }"
            for icu_lib in icui18n icuuc icudata; do
              patchelf --add-needed "lib''${icu_lib}.so.$icu_major_v" "$elf"
            done
          }
          patchelf_common() {
            declare elf="''${1?}"

            chmod +x "$elf"
            patchelf_add_icu_as_needed "$elf"
            patchelf --add-needed "libssl.so" "$elf"
            patchelf --add-needed "libz.so.1" "$elf"
            patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
              --set-rpath "${
                lib.makeLibraryPath [ stdenv.cc.cc openssl zlib icu.out ]
              }:\$ORIGIN" \
              "$elf"
          }

          sed -i -E -e 's/(e.extensionPath,"cache")/require("os").homedir(),".cache","Microsoft", "csdevkit","cache"/g' "$PWD/dist/extension.js"
          sed -i -E -e 's/o\.chmod/console.log/g' "$PWD/dist/extension.js"

          patchelf_common ./components/vs-green-server/platforms/linux-x64/node_modules/@microsoft/visualstudio-server.linux-x64/Microsoft.VisualStudio.Code.Server
          patchelf_common ./components/vs-green-server/platforms/linux-x64/node_modules/@microsoft/servicehub-controller-net60.linux-x64/Microsoft.ServiceHub.Controller
          patchelf_common ./components/vs-green-server/platforms/linux-x64/node_modules/@microsoft/visualstudio-code-servicehost.linux-x64/Microsoft.VisualStudio.Code.ServiceHost
          patchelf_common ./components/vs-green-server/platforms/linux-x64/node_modules/@microsoft/visualstudio-reliability-monitor.linux-x64/Microsoft.VisualStudio.Reliability.Monitor
        '';
      })
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
        "source.addMissingImports" = true;
        "source.fixAll.eslint" = true;
        "source.organizeImports" = true;
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
      "dotnetAcquisitionExtension.enableTelemetry" = false;
      "dotnetAcquisitionExtension.existingDotnetPath" = [
        {
            "extensionId" = "ms-dotnettools.csharp";
            "path" = "dotnet";
        }
      ];
      "dotnet.preferCSharpExtension" = false;
    };
  };
}
