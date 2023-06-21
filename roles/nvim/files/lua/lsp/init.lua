local servers = {
    "bashls",
    "dockerls",
    "gopls",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "sqlls",
    "terraformls",
    "tsserver",
    "vuels",
    "yamlls",
}

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>k', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>j', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'H', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leadre>wr', vim.lsp.buf.remove_workspace_folder,
                   bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>re', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150
}

for _, server in ipairs(servers) do
    if server == "vuels" then
        nvim_lsp[server].setup {
          on_attach = on_attach,
          flags = lsp_flags,
          cmd = { "vue-language-server" , "--stdio" },
          init_options = {
              typescript = { tsdk = "/usr/lib/node_modules/typescript/lib" }
          }
      }
    elseif server == "yamlls" then
        nvim_lsp[server].setup {
            on_attach = on_attach,
            flags = lsp_flags,
            settings = {
                yaml = {
                    keyOrdering = false
                }
            },
            cmd = { "yaml-language-server", "--stdio" }
        }
    else
        nvim_lsp[server].setup {on_attach = on_attach, flags = lsp_flags}
    end
end

local border = {
    {"┏", "FloatBorder"}, {"━", "FloatBorder"}, {"┓", "FloatBorder"},
    {"┃", "FloatBorder"}, {"┛", "FloatBorder"}, {"━", "FloatBorder"},
    {"┗", "FloatBorder"}, {"┃", "FloatBorder"}
}
-- Override floating windows globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define("DiagnosticSignError", {
    text = "",
    numhl = "DiagnosticError",
    texthl = "DiagnosticError"
})
vim.fn.sign_define("DiagnosticSignWarning", {
    text = "",
    numhl = "DiagnosticWarning",
    texthl = "DiagnosticWarning"
})
vim.fn.sign_define("DiagnosticSignInformation", {
    text = "",
    numhl = "DiagnosticInformation",
    texthl = "DiagnosticInformation"
})
vim.fn.sign_define("DiagnosticSignHint", {
    text = "",
    numhl = "DiagnosticHint",
    texthl = "DiagnosticSignHint"
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.flake8.with({
            args = {
                "--config /home/philip/.config/flake8", "--stdin-display-name",
                "$FILENAME", "-"
            }
        }),
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.code_actions.eslint,
        -- null_ls.builtins.formatting.prettier
    },
    on_attach = on_attach
})
