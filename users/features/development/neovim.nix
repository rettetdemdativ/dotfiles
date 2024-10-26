{ inputs, config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      # UI
      nvim-tree-lua
      telescope-nvim
      which-key-nvim
      lualine-nvim
      rainbow-delimiters-nvim
      vim-illuminate
      trouble-nvim

      # Themes
      vscode-nvim
      tokyonight-nvim

      # Movement
      leap-nvim

      # Git
      neogit
      gitsigns-nvim

      # LSP and TreeSitter
      nvim-treesitter
      nvim-cmp
      mini-pairs
      nvim-lspconfig
      none-ls-nvim
    ];
  };
  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = ../../.config/nvim;
    };
  };
}
