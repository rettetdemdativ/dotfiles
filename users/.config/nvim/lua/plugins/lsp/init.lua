return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"hrsh7th/cmp-nvim-lsp",
			},
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
			-- Automatically format on save
			autoformat = true,
			-- LSP Server Settings
			servers = {
				bashls = {},
				clangd = {
					capabilities = {
						offsetEncoding = "utf8",
					},
				},
				cssls = {},
				eslint = {},
				tsserver = {},
				angularls = {},
				svelte = {},
				html = {},
				tailwindcss = {},
				gopls = {},
				rust_analyzer = {
                    cmd = { "rust-analyzer" },
                },
				pyright = {},
				nil_ls = {},
				omnisharp = {
					cmd = { "omnisharp" },

					-- Enables support for reading code style, naming convention and analyzer
					-- settings from .editorconfig.
					enable_editorconfig_support = true,

					-- Specifies whether 'using' directives should be grouped and sorted during
					-- document formatting.
					organize_imports_on_format = false,

					-- Enables support for showing unimported types and unimported extension
					-- methods in completion lists. When committed, the appropriate using
					-- directive will be added at the top of the current file. This option can
					-- have a negative impact on initial completion responsiveness,
					-- particularly for the first few completion sessions after opening a
					-- solution.
					enable_import_completion = false,

					-- Specifies whether to include preview versions of the .NET SDK when
					-- determining which version to use for project loading.
					sdk_include_prereleases = true,
				},
			},
			setup = {},
		},
		---@diagnostic disable-next-line: unused-local
		config = function(plugin, opts)
			-- diagnostics
			for name, icon in pairs(require("const").icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			local mlsp = require("mason-lspconfig")
			local available = mlsp.get_available_servers()

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup_handlers({ setup })
		end,
	},

	-- formatters
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					filter = function(client)
						-- apply whatever logic you want (in this example, we'll only use null-ls)
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end

			-- if you want to set up formatting on save, you can use this as a callback
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			local null_ls = require("null-ls")
			-- you can reuse a shared lspconfig on_attach callback here
			return {
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						--vim.api.nvim_create_autocmd("BufWritePre", {
						--	group = augroup,
						--	buffer = bufnr,
						--	callback = function()
                        --        vim.lsp.buf.format({ async = false })
						--	end,
						--})
					end
				end,
				sources = {
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.rustfmt,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black,
					--null_ls.builtins.diagnostics.pylint,
					--null_ls.builtins.diagnostics.checkstyle.with({
					--	extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
					--}),
				},
			}
		end,
	},

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ensure_installed = {
				"prettierd",
				"stylua",
				"selene",
				"luacheck",
				"eslint_d",
				"shellcheck",
				"shfmt",
				"black",
				"isort",
				"flake8",
				"jdtls",
				"omnisharp",
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
}
