require("config")

-- Load lazyvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
	"plugins", -- load from 'plugins' Lua module
	{
		lockfile = "/persist/home/inet/.config/nvim/lazy-lock.json", -- lockfile generated after running update.
	}
)

require("vscode").load()
vim.cmd("colorscheme vscode")
--require("nightfox").load()
--vim.cmd("colorscheme carbonfox")

--vim.cmd("colorscheme tokyonight")

vim.api.nvim_set_hl(0, 'RDYellow', { fg = "#ffd602" })
vim.api.nvim_set_hl(0, 'RDViolet', { fg = "#d66ed2" })
vim.api.nvim_set_hl(0, 'RDBlue', { fg = "#569cd6" })
vim.api.nvim_set_hl(0, 'RDOrange', { fg = "#d7ba7d" })
vim.api.nvim_set_hl(0, 'RDCyan', { fg = "#4ec9b0" })
vim.api.nvim_set_hl(0, 'RDGreen', { fg = "#6a9955" })
vim.api.nvim_set_hl(0, 'RDRed', { fg = "#d16969" })
