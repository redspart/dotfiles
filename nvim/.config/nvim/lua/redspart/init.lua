require("redspart.sets")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.do_filetype_lua = 1
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--vim.cmd [[ colorscheme dracula_blood ]]

local plugins = {
    -- Go
    "ray-x/go.nvim",
    "ray-x/guihua.lua",

    -- Needed for telescope
    --"nvim-lua/popup.nvim",
    --"nvim-lua/plenary.nvim",
    --"nvim-telescope/telescope.nvim",
    --"nvim-telescope/telescope-fzy-native.nvim",

    -- Python
    --"davidhalter/jedi-vim",
    --use "puremourning/vimspector"
    -- Worktree
    --"ThePrimeagen/git-worktree.nvim",

    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- Themes
    "ray-x/starry.nvim"
}

require("lazy").setup({
	spec = "redspart.lazy",
	change_detection = { notify = false }
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local GlobalGroup  = augroup('Global', {})

autocmd('LspAttach', {
    group = GlobalGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gD", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

