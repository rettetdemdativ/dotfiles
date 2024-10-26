require("config")

require("vscode").load()
vim.cmd("colorscheme vscode")
--vim.cmd("colorscheme tokyonight")

vim.api.nvim_set_hl(0, 'RDYellow', { fg = "#ffd602" })
vim.api.nvim_set_hl(0, 'RDViolet', { fg = "#d66ed2" })
vim.api.nvim_set_hl(0, 'RDBlue', { fg = "#569cd6" })
vim.api.nvim_set_hl(0, 'RDOrange', { fg = "#d7ba7d" })
vim.api.nvim_set_hl(0, 'RDCyan', { fg = "#4ec9b0" })
vim.api.nvim_set_hl(0, 'RDGreen', { fg = "#6a9955" })
vim.api.nvim_set_hl(0, 'RDRed', { fg = "#d16969" })
