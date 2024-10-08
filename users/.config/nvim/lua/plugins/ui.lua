return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function(_, opts)
			require("nvim-tree").setup({
                view = {
                    side = "right",
                },
            })
		end,
        keys = {
			{ "<C-n>", "<CMD>NvimTreeToggle<CR>" },
		}
    },

	{
		"s1n7ax/nvim-window-picker",
		config = function(_, opts)
			require("window-picker").setup()
		end,
	},

	-- telescope.nvim
	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>" },
			{ "<leader>fg", ":Telescope live_grep<CR>" },
			{ "<leader>fb", ":Telescope buffers<CR>" },
			{ "<leader>fh", ":Telescope help_tags<CR>" },
			{ "<leader>fc", ":Telescope git_commits<CR>" },
			{ "<leader>fm", ":Telescope man_pages<CR>" },
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
			},
		},
	},

	-- nvim-notify
	-- better vim.notify
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	},

	-- dressing.nvim
	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<A-c>", "<CMD>BufferLinePickClose<CR>" },
			{ "<A-.>", "<CMD>BufferLineCycleNext<CR>" },
			{ "<A-,>", "<CMD>BufferLineCyclePrev<CR>" },
			{ "<A-S-.>", "<CMD>BufferLineMoveNext<CR>" },
			{ "<A-S-,>", "<CMD>BufferLineMovePrev<CR>" },
			{ "<A-1>", "<CMD>BufferLineGoToBuffer 1<CR>" },
			{ "<A-2>", "<CMD>BufferLineGoToBuffer 2<CR>" },
			{ "<A-3>", "<CMD>BufferLineGoToBuffer 3<CR>" },
			{ "<A-4>", "<CMD>BufferLineGoToBuffer 4<CR>" },
			{ "<A-5>", "<CMD>BufferLineGoToBuffer 5<CR>" },
			{ "<A-6>", "<CMD>BufferLineGoToBuffer 6<CR>" },
			{ "<A-7>", "<CMD>BufferLineGoToBuffer 7<CR>" },
			{ "<A-8>", "<CMD>BufferLineGoToBuffer 8<CR>" },
			{ "<A-9>", "<CMD>BufferLineGoToBuffer 9<CR>" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("const").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},

	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(plugin)
			local icons = {
				diagnostics = {
					Error = " ",
					Warn = " ",
					Hint = " ",
					Info = " ",
				},
				git = {
					added = " ",
					modified = " ",
					removed = " ",
				},
				kinds = {
					Array = " ",
					Boolean = " ",
					Class = " ",
					Color = " ",
					Constant = " ",
					Constructor = " ",
					Copilot = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Folder = " ",
					Function = " ",
					Interface = " ",
					Key = " ",
					Keyword = " ",
					Method = " ",
					Module = " ",
					Namespace = " ",
					Null = "ﳠ ",
					Number = " ",
					Object = " ",
					Operator = " ",
					Package = " ",
					Property = " ",
					Reference = " ",
					Snippet = " ",
					String = " ",
					Struct = " ",
					Text = " ",
					TypeParameter = " ",
					Unit = " ",
					Value = " ",
					Variable = " ",
				},
			}

			local function fg(name)
				return function()
					---@type {foreground?:number}?
					local hl = vim.api.nvim_get_hl_by_name(name, true)
					return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
				end
			end
			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
		  -- stylua: ignore
		  {
		    function() return require("nvim-navic").get_location() end,
		    cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
		  },
					},
					lualine_y = {
		  -- stylua: ignore
		  {
		    function() return require("noice").api.status.command.get() end,
		    cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
		    color = fg("Statement")
		  },
		  -- stylua: ignore
		  {
		    function() return require("noice").api.status.mode.get() end,
		    cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
		    color = fg("Constant") ,
		  },
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = fg("Special"),
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_z = {
						{ "progress", separator = "", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
				},
				extensions = { "neo-tree" },
			}
		end,
	},

	{ 
		"lukas-reineke/indent-blankline.nvim", 
		main = "ibl", 
		opts = {
			indent = { 
				char = "" ,
				tab_char =  "",
			},
		} 
	},

    {
        "hiphish/rainbow-delimiters.nvim",
        config = function()
            

            require("rainbow-delimiters.setup").setup {
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                highlight = {
                    'RDYellow',
                    'RDViolet',
                    'RDBlue',
                    --'RDOrange',
                    --'RDCyan',
                    --'RDGreen',
                    --'RDRed',
                },
            }
        end,
    },

	-- noice.nvim
	-- experimental notifications ui
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
	  -- stylua: ignore
	  keys = {
	    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect CMDline" },
	    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
	    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
	    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
	    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
	    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
	  },
	},

	{ "MunifTanjim/nui.nvim", lazy = true },

    ---@module "neominimap.config.meta"
    {
        "Isrothy/neominimap.nvim",
        version = "v3.*.*",
        enabled = true,
        lazy = false, -- NOTE: NO NEED to Lazy load
        -- Optional
        keys = {
            -- Global Minimap Controls
            { "<leader>m", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
            { "<leader>r", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },
        },
        init = function()
            -- The following options are recommended when layout == "float"
            vim.opt.wrap = false
            vim.opt.sidescrolloff = 36 -- Set a large value

            --- Put your configuration here
            ---@type Neominimap.UserConfig
            vim.g.neominimap = {
                auto_enable = false,
            }
        end,
    }
}
