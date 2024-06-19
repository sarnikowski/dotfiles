local servers = {
    "bashls", "clangd", "dockerls", "gopls", "jsonls", "lua_ls", "pyright",
    "rust_analyzer", "sqlls", "terraformls", "tsserver", "vuels", "yamlls"
}

local nvim_lsp = require("lspconfig")
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Mappings.
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "H", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leadre>wr", vim.lsp.buf.remove_workspace_folder,
                   bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>re", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150
}

local mason_registry = require('mason-registry')
local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

for _, server in ipairs(servers) do
    if server == "vuels" then
        nvim_lsp[server].setup({
            on_attach = on_attach,
            flags = lsp_flags,
            cmd = {"vue-language-server", "--stdio"},
            init_options = {
                typescript = {tsdk = "/usr/lib/node_modules/typescript/lib"}
            }
        })
    elseif server == "tsserver" then
        nvim_lsp[server].setup({
            on_attach = on_attach,
            flags = lsp_flags,
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vue_language_server_path,
                        languages = { "vue" },
                    },
                },
            },
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
        })
    elseif server == "yamlls" then
        nvim_lsp[server].setup({
            on_attach = on_attach,
            flags = lsp_flags,
            settings = {yaml = {keyOrdering = false}},
            cmd = {"yaml-language-server", "--stdio"}
        })
    elseif server == "lua_ls" then
        nvim_lsp[server].setup({
            on_attach = on_attach,
            flags = lsp_flags,
            settings = {Lua = {diagnostic = {globals = "vim"}}},
            cmd = {"yaml-language-server", "--stdio"}
        })
    else
        nvim_lsp[server].setup({on_attach = on_attach, flags = lsp_flags})
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

vim.diagnostic.config{
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅙",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN] = "DiagnosticWarning",
            [vim.diagnostic.severity.INFO] = "DiagnosticInformation",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN] = "DiagnosticWarning",
            [vim.diagnostic.severity.INFO] = "DiagnosticInformation",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
    }
}
