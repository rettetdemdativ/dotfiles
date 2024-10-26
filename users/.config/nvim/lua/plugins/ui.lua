require("nvim-tree").setup({
    view = {
        side = "right",
    },
})

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local wk = require("which-key")

telescope.setup({
    defaults = {
        layout_config = {
            horizontal = {
                width = 0.9,
            },
        },
    },
})

telescope.load_extension("file_browser")

wk.register({
    T = { builtin.builtin, "Telescope - find picker" },
    f = {
        name = "Telescope",
        f = { builtin.find_files, "Find file" },
        g = { builtin.live_grep, "Live grep" },
        b = { builtin.buffers, "Buffers" },
        h = { builtin.help_tags, "Help tags" },
        t = { builtin.treesitter, "Treesitter" },
        r = { builtin.lsp_references, "References" },
        c = { builtin.commands, "Commands" },
        e = { telescope.extensions.file_browser.file_browser, "File browser" },
    },
}, { prefix = "<leader>" })

vim.keymap.set(
    "n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>"
)
vim.keymap.set(
    "n", "<leader>fg", ":Telescope live_grep<CR>"
)
vim.keymap.set(
    "n", "<leader>fg", ":Telescope buffers<CR>"
)
vim.keymap.set(
    "n", "<leader>fc", ":Telescope git_commits<CR>"
)

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
