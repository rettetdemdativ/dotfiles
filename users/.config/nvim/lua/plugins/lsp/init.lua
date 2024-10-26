require("nvimtools/none-ls.nvim").setup({
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
        ts_ls = {},
        angularls = {},
        svelte = {},
        html = {},
        tailwindcss = {},
        gopls = {},
        rls = {},
        pyright = {},
        nil_ls = {},
    }
})

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
