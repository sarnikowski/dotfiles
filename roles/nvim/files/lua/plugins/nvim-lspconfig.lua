local servers = {
  "bashls",
  "clangd",
  "dockerls",
  "gopls",
  "jsonls",
  "lua_ls",
  "pyright",
  "ruff_lsp",
  "rust_analyzer",
  "sqlls",
  "terraformls",
  "ts_ls",
  "vuels",
  "yamlls"
}

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150
}

local on_attach = function(client, bufnr)
  if client.name == 'ruff_lsp' then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local nvim_lsp = require("lspconfig")
    local mason_registry = require("mason-registry")
    local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path() ..
                                         "/node_modules/@vue/language-server"
    for _, server in ipairs(servers) do
      if server == "vuels" then
        nvim_lsp[server].setup({
          on_attach = on_attach,
          flags = lsp_flags,
          cmd = { "vue-language-server", "--stdio" },
          init_options = { typescript = { tsdk = "/usr/lib/node_modules/typescript/lib" } }
        })
      elseif server == "ts_ls" then
        nvim_lsp[server].setup({
          on_attach = on_attach,
          flags = lsp_flags,
          init_options = {
            plugins = { { name = "@vue/typescript-plugin", location = vue_language_server_path, languages = { "vue" } } }
          },
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
        })
      elseif server == "yamlls" then
        nvim_lsp[server].setup({
          on_attach = on_attach,
          flags = lsp_flags,
          settings = { yaml = { keyOrdering = false } },
          cmd = { "yaml-language-server", "--stdio" }
        })
      elseif server == "lua_ls" then
        nvim_lsp[server].setup({
          on_attach = on_attach,
          flags = lsp_flags,
          settings = { Lua = { diagnostic = { globals = "vim" } } },
          cmd = { "yaml-language-server", "--stdio" }
        })
      elseif server == "pyright" then
        nvim_lsp[server].setup({
          on_attach = on_attach,
          flags = lsp_flags,
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
          },
        })
      else
        nvim_lsp[server].setup({ on_attach = on_attach, flags = lsp_flags })
      end
    end
  end,
  keys = {
    { "<leader>rs", "<cmd>LspRestart<cr>", desc = "Restart LSP server" },
    { "<leader>e", vim.diagnostic.open_float, desc = "Open float" },
    { "<leader>dk", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
    { "<leader>dj", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
    { "<leader>q", vim.diagnostic.setloclist, desc = "Set location list" },
    { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace folder" },
    { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
    {
      "<leader>wl",
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      desc = "List workspace folders"
    },
    { "<leader>D", vim.lsp.buf.type_definition, desc = "Type definition" },
    { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
    { "<leader>re", vim.lsp.buf.references, desc = "References" },
    { "<leader>fm", vim.lsp.buf.format, desc = "Format" },
    { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
    { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
    { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "H", vim.lsp.buf.signature_help, desc = "Signature help" }
  }
}
