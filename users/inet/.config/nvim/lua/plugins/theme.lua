return {
	{
		"Mofiqul/vscode.nvim",
		enabled = false,
		lazy = true,
		priority = 1000,
		config = function()
			require("vscode").setup({
				italic_comments = true,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = false,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				term_colors = true,
				transparent_background = false,
				no_italic = false,
				no_bold = false,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = { "italic" },
					functions = {},
					keywords = { "italic" },
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {
					mocha = {
						base = "#000000",
						mantle = "#000000",
						crust = "#000000",
					},
				},
				highlight_overrides = {
					mocha = function(C)
						return {
							TabLineSel = { bg = C.pink },
							CmpBorder = { fg = C.surface2 },
							Pmenu = { bg = C.none },
							TelescopeBorder = { link = "FloatBorder" },
						}
					end,
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = true,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
			})
		end,
	},

	{
		"EdenEast/nightfox.nvim",
		enabled = true,
		lazy = true,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					compile_path = vim.fn.stdpath("cache") .. "/nightfox",
					compile_file_suffix = "_compiled", -- Compiled file suffix
					transparent = false, -- Disable setting background
					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
					dim_inactive = false, -- Non focused panes set to alternative background
					module_default = true, -- Default enable value for modules
					styles = { -- Style to be applied to different syntax groups
						comments = "italic", -- Value is any valid attr-list value `:help attr-list`
						conditionals = "italic",
						constants = "NONE",
						functions = "NONE",
						keywords = "italic",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},
					modules = { -- List of various plugins and additional options
						"nvim-cmp",
						"lsp-trouble.nvim",
						"neo-tree",
						"telescope.nvim",
						"which-key.nvim",
					},
				},
				specs = {
					all = {
						syntax = {
							type = "#4EC9B0",
							builtin1 = "#4EC9B0",
							--operator = "orange",
							string = "#D7BA7D",
						},
					},
				},
			})
		end,
	},
}
