{ inputs, config, pkgs, ... }:
let selectOpts = "{behavior = cmp.SelectBehavior.Select}";
in {
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.nixvim = {
    enable = true;
    opts = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 4; # Tab width should be 4
      tabstop = 4;
      smartcase = true;
      smartindent = true;
      expandtab = true;
      termguicolors = true;
      cmdheight = 0;
    };
    keymaps = [
      {
        mode = "n";
        key = "<C-n>";
        options.silent = true;
        action = "<cmd>NvimTreeToggle<CR>";
      }
      {
        mode = "n";
        key = "<leader>ff";
        options.silent = true;
        action = "<cmd>:Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        options.silent = true;
        action = "<cmd>:Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>fb";
        options.silent = true;
        action = "<cmd>:Telescope buffers<CR>";
      }
      {
        mode = "n";
        key = "<leader>fc";
        options.silent = true;
        action = "<cmd>:Telescope git_commits<CR>";
      }
      {
        mode = "n";
        key = "<leader>fm";
        options.silent = true;
        action = "<cmd>:Telescope man_pages<CR>";
      }
      {
        mode = "n";
        key = "<C-h>";
        options.silent = true;
        action = "<cmd>:Lspsaga hover_doc<CR>";
      }
    ];
    colorschemes.vscode = {
      enable = true;
      settings = { italic_comments = true; };
    };
    highlight = {
      RDYellow = { fg = "#ffd602"; };
      RDViolet = { fg = "#d66ed2"; };
      RDBlue = { fg = "#569cd6"; };
      RDOrange = { fg = "#d7ba7d"; };
      RDCyan = { fg = "#4ec9b0"; };
      RDGreen = { fg = "#6a9955"; };
      RDRed = { fg = "#d16969"; };
    };
    #colorschemes.tokyonight = {
    #enable = true;
    #settings = {
    #style = "storm";
    #styles = {
    #comments = { italic = true; };
    #floats = "dark";
    #functions = { };
    #keywords = { italic = true; };
    #sidebars = "dark";
    #variables = { };
    #};
    #};
    #};
    plugins = {
      # Editor
      illuminate.enable = true;
      rainbow-delimiters = {
        enable = true;
        highlight = [
          "RDYellow"
          "RDViolet"
          "RDBlue"
          "RDOrange"
          "RDCyan"
          "RDGreen"
          "RDRed"
        ];
      };
      leap.enable = true;
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = "fallback";
            timeout_ms = 500;
          };
          formatters_by_ft = {
            c = [ "clang-format" ];
            cpp = [ "clang-format" ];
            rust = [ "rustfmt" ];
            go = [ "gofmt" ];
            python = [ "black" ];
            javascript = [ "prettierd" ];
            typescript = [ "prettierd" ];
            css = [ "prettierd" ];
            html = [ "prettierd" ];
            json = [ "prettierd" ];
            kotlin = [ "ktfmt" ];
            lua = [ "stylua" ];
            markdown = [ "prettierd" ];
            nix = [ "nixfmt" ];
            terraform = [ "tofu_fmt" ];
            tf = [ "tofu_fmt" ];
            typst = [ "typstyle" ];
          };
        };
      };
      lint = {
        enable = true;
        lintersByFt = {
          python = [ "pylint" ];
          javascript = [ "eslint_d" ];
          typescript = [ "eslint_d" ];
        };
      };
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          angular
          bash
          c
          cpp
          css
          dockerfile
          go
          gomod
          gosum
          groovy
          hcl
          html
          java
          javascript
          json
          jsonc
          kotlin
          llvm
          lua
          make
          markdown
          nix
          perl
          python
          regex
          rust
          sql
          svelte
          terraform
          toml
          tsx
          typescript
          typst
          yaml
        ];
      };
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
      treesitter-textobjects.enable = true;
      trouble = { enable = true; };

      # UI
      gitgutter.enable = true;
      gitblame.enable = true;
      lualine = {
        enable = true;
        settings = {
          options = {
            globalstatus = true;
            theme = "papercolor_light";
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "";
              right = "";
            };
          };
        };
      };
      nvim-tree = {
        enable = true;
        git.ignore = false;
        updateFocusedFile.enable = true;
        view = { side = "right"; };
      };
      barbar = {
        enable = true;
        settings = { animations = false; };
        keymaps = {
          close = { key = "<C-d>"; };
          closeAllButCurrent = { key = "<C-S-d>"; };
          goTo1 = { key = "<C-1>"; };
          goTo2 = { key = "<C-2>"; };
          goTo3 = { key = "<C-3>"; };
          goTo4 = { key = "<C-4>"; };
          goTo5 = { key = "<C-5>"; };
          goTo6 = { key = "<C-6>"; };
          goTo7 = { key = "<C-7>"; };
          goTo8 = { key = "<C-8>"; };
          goTo9 = { key = "<C-9>"; };
        };
      };
      telescope.enable = true;
      which-key.enable = true;
      web-devicons.enable = true;

      # LSP
      lsp = {
        enable = true;
        inlayHints = true;
        keymaps = {
          lspBuf = {
            "K" = "hover";
            "gD" = "declaration";
            "gd" = "definition";
            "gr" = "references";
            "gI" = "implementation";
            "gy" = "type_definition";
            "<leader>ca" = "code_action";
            "<leader>cr" = "rename";
            "<leader>wl" = "list_workspace_folders";
            "<leader>wr" = "remove_workspace_folder";
            "<leader>wa" = "add_workspace_folder";
          };
        };
        servers = {
          angularls.enable = true;
          ccls.enable = true;
          dockerls.enable = true;
          docker_compose_language_service.enable = true;
          gopls.enable = true;
          lua_ls.enable = true;
          jdtls.enable = true;
          nil_ls.enable = true;
          nixd.enable = true;
          perlnavigator.enable = true;
          pylsp.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          svelte.enable = true;
          tinymist.enable = true;
          ts_ls.enable = true;
        };
      };
      lspsaga = {
        enable = true;
        beacon.enable = false;
        lightbulb.enable = false;
      };
      lsp-signature.enable = true;

      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          performance = { debounce = 150; };
          sources = [
            { name = "path"; }
            {
              name = "nvim_lsp";
              keywordLength = 1;
            }
            {
              name = "buffer";
              keywordLength = 3;
            }
            #{ name = "supermaven"; }
          ];

          formatting = {
            fields = [ "menu" "abbr" "kind" ];
            format = ''
              function(entry, item)
                local menu_icon = {
                  nvim_lsp = '[LSP]',
                  buffer = '[BUF]',
                  path = '[PATH]',
                }

                item.menu = menu_icon[entry.source.name]
                return item
              end
            '';
          };

          mapping = {
            "<Up>" = "cmp.mapping.select_prev_item(${selectOpts})";
            "<Down>" = "cmp.mapping.select_next_item(${selectOpts})";

            "<C-p>" = "cmp.mapping.select_prev_item(${selectOpts})";
            "<C-n>" = "cmp.mapping.select_next_item(${selectOpts})";

            "<C-u>" = "cmp.mapping.scroll_docs(-4)";
            "<C-d>" = "cmp.mapping.scroll_docs(4)";

            "<C-e>" = "cmp.mapping.abort()";
            "<C-y>" = "cmp.mapping.confirm({select = true})";
            "<CR>" = "cmp.mapping.confirm({select = false})";

            "<C-f>" = ''
              cmp.mapping(
                function(fallback)
                  if luasnip.jumpable(1) then
                    luasnip.jump(1)
                  else
                    fallback()
                  end
                end,
                { "i", "s" }
              )
            '';

            "<C-b>" = ''
              cmp.mapping(
                function(fallback)
                  if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end,
                { "i", "s" }
              )
            '';

            "<Tab>" = ''
              cmp.mapping(
                function(fallback)
                  local col = vim.fn.col('.') - 1

                  if cmp.visible() then
                    cmp.select_next_item(select_opts)
                  elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                    fallback()
                  else
                    cmp.complete()
                  end
                end,
                { "i", "s" }
              )
            '';

            "<S-Tab>" = ''
              cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item(select_opts)
                  else
                    fallback()
                  end
                end,
                { "i", "s" }
              )
            '';
          };
          window = {
            completion = {
              border = "rounded";
              winhighlight =
                "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
              zindex = 1001;
              scrolloff = 0;
              colOffset = 0;
              sidePadding = 1;
              scrollbar = true;
            };
            documentation = {
              border = "rounded";
              winhighlight =
                "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
              zindex = 1001;
              maxHeight = 20;
            };
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-treesitter.enable = true;

      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      dap-go.enable = true;
      dap-python.enable = true;
      dap.enable = true;

      autoclose.enable = true;
    };
  };
}
