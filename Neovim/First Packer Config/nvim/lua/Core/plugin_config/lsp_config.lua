require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {'lua_ls', 'eslint', 'tsserver', 'cssls', 'cssmodules_ls'},
})

local on_attach = function()
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)



end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
}
require("lspconfig").eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    bin = 'eslint', -- or `eslint_d`
    code_actions = {
        enable = true,
        apply_on_save = {
            enable = true,
            types = { "directive", "problem", "suggestion", "layout" },
        },
        disable_rule_comment = {
            enable = true,
            location = "separate_line", -- or `same_line`
        },
    },
    diagnostics = {
        enable = true,
        report_unused_disable_directives = false,
        run_on = "type", -- or `save`
    },
}

require("lspconfig").cssls.setup {
    default_config = {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
        single_file_support = true,
        settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
        },
    },
    docs = {
        description = [[

        https://github.com/hrsh7th/vscode-langservers-extracted

        `css-languageserver` can be installed via `npm`:

        ```sh
        npm i -g vscode-langservers-extracted
        ```

        Neovim does not currently include built-in snippets. `vscode-css-language-server` only provides completions when snippet support is enabled. To enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.

        ```lua
        --Enable (broadcasting) snippet capability for completion
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require'lspconfig'.cssls.setup {
            capabilities = capabilities,
        }
        ```
        ]],
        default_config = {
            root_dir = [[root_pattern("package.json", ".git") or bufdir]],
        },
    },

}
