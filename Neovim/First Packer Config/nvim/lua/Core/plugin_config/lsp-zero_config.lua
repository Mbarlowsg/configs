require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {'lua_ls', 'eslint', 'tsserver', 'cssls', 'cssmodules_ls'}
})
local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup_servers({'lua_ls', 'eslint', 'tsserver', 'cssls', 'cssmodules_ls'})



lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

end)


local lua_opts = lsp.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)
