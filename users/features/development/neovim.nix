{ inputs, config, pkgs, username, ... }:
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
        key = "<leader>f";
        options.silent = true;
        action = "<cmd>:lua vim.lsp.buf.format { async = true }<CR>";
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
      {
        mode = "n";
        key = "<leader>tt";
        options.silent = true;
        action = "<cmd>:Trouble diagnostics toggle<cr>";
      }
      {
        mode = "n";
        key = "<leader>ts";
        options.silent = true;
        action = "<cmd>:Trouble symbols toggle focus=false<cr>";
      }
      {
        mode = "n";
        key = "<leader>td";
        options.silent = true;
        action = "<cmd>:Trouble lsp toggle focus=false win.position=right<cr>";
      }
    ];
    colorschemes.vscode = {
      enable = true;
      settings = { italic_comments = true; };
    };
    #colorschemes.cyberdream = {
    #  enable = true;
    #  settings = { italic_comments = true; };
    #};
    #colorschemes.tokyonight = {
    #  enable = true;
    #  settings = {
    #    style = "night";
    #    styles = { comments = { italic = true; }; };
    #  };
    #};
    highlight = {
      RDYellow = { fg = "#ffd602"; };
      RDViolet = { fg = "#d66ed2"; };
      RDBlue = { fg = "#569cd6"; };
      RDOrange = { fg = "#d7ba7d"; };
      RDCyan = { fg = "#4ec9b0"; };
      RDGreen = { fg = "#6a9955"; };
      RDRed = { fg = "#d16969"; };
    };
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
      #conform-nvim = {
      #  enable = true;
      #  settings = {
      #    format_on_save = {
      #      lsp_fallback = "fallback";
      #      timeout_ms = 500;
      #    };
      #    formatters_by_ft = {
      #      c = [ "clang-format" ];
      #      cpp = [ "clang-format" ];
      #      #rust = [ "rust-analyzer" ];
      #      go = [ "gofmt" ];
      #      python = [ "black" ];
      #      javascript = [ "prettierd" ];
      #      typescript = [ "prettierd" ];
      #      css = [ "prettierd" ];
      #      html = [ "prettierd" ];
      #      json = [ "prettierd" ];
      #      kotlin = [ "ktfmt" ];
      #      lua = [ "stylua" ];
      #      markdown = [ "prettierd" ];
      #      nix = [ "nixfmt" ];
      #      terraform = [ "tofu_fmt" ];
      #      tf = [ "tofu_fmt" ];
      #      typst = [ "typstyle" ];
      #    };
      #  };
      #};
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
          bash
          c
          cpp
          css
          dockerfile
          go
          gomod
          gosum
          html
          javascript
          json
          jsonc
          llvm
	  #lua
          make
          markdown
          nix
          perl
          python
          regex
          rust
          sql
          toml
          tsx
          typescript
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
        view = {
          side = "left";
          width = 40;
        };
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
          ccls.enable = true;
          dockerls.enable = true;
          docker_compose_language_service.enable = true;
          gopls.enable = true;
          lua_ls.enable = true;
          nil_ls = {
            enable = true;
            settings = { formatting.command = [ "nixfmt" ]; };
          };
          nixd.enable = true;
          perlpls = {
            enable = true;
            #settings = {
            #    inc = [ "~/workspace/projects/proxmox" ];
            #};
          };
          ts_ls.enable = true;
        };
      };
      lspsaga = {
        enable = true;
        beacon.enable = false;
        lightbulb.enable = false;
      };
      lsp-signature.enable = true;

      blink-cmp = {
        enable = true;
        settings = {
          completion = {
            accept = {
              auto_brackets = {
                enabled = true;
                #semantic_token_resolution = { enabled = false; };
              };
            };
            documentation = { auto_show = true; };
          };
          keymap = { preset = "super-tab"; };
          signature = { enabled = true; };
        };
      };

      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      dap-go.enable = true;
      dap-python.enable = true;
      dap-rr.enable = true;
      dap.enable = true;

      autoclose.enable = true;
      whitespace = {
	enable = true;
	settings = {
	  ignored_filetypes = [
	    "TelescopePrompt"
	    "Trouble"
	    "checkhealth"
	    "fzf"
	  ];
	};
      };

      rustaceanvim = { enable = true; };

      flutter-tools = { enable = true; };
    };
  };
}
