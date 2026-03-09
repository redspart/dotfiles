local server_list = { "lua_ls", "efm", "rust_analyzer", "terraformls",
    "jedi_language_server", "gopls" }
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = server_list })
local lspConfig = require("lspconfig")


local nnoremap = require("core.keymap").nnoremap


local custom_on_attach = function(_)
    -- actions
    nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
    nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
    nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
    nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true })
    nnoremap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true })
    nnoremap("<space>f", "<cmd>lua vim.lsp.buf.format()<CR>")
    nnoremap("<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
    nnoremap("<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })

    -- workspace
    nnoremap("<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { silent = true })
    nnoremap("<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { silent = true })
    nnoremap("<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", { silent = true })

    -- moveme
    nnoremap("<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { silent = true })
    nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true })
    nnoremap("<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { silent = true })
    nnoremap("<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", { silent = true })

    -- diagno
    nnoremap("[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { silent = true })
    nnoremap("]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { silent = true })
end

for _, lsp in ipairs(server_list) do
    lspConfig[lsp].setup { on_attach = custom_on_attach }
end


-- compe
--compe = {}
--compe.enabled = v:true
--compe.autocomplete = v:true
--compe.debug = v:false
--compe.min_length = 1
--compe.preselect = 'enable'
--compe.throttle_time = 80
--compe.source_timeout = 200
--compe.incomplete_delay = 400
--compe.max_abbr_width = 100
--compe.max_kind_width = 100
--compe.max_menu_width = 100
--compe.documentation = v:true
--compe.source = {}
--compe.source.path = v:true
--compe.source.buffer = v:true
--compe.source.calc = v:true
--compe.source.nvim_lsp = v:true
--compe.source.nvim_lua = v:true
--compe.source.vsnip = v:true
