return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
    ensure_installed = {
      "bash-language-server",
      "debugpy",
      "dockerfile-language-server",
      "gopls",
      "json-lsp",
      "lua-language-server",
      "prettier",
      "pyright",
      "rust-analyzer",
      "sqlls",
      "typescript-language-server",
      "vue-language-server",
      "yaml-language-server",
      "cpptools",
      "delve",
      "debugpy",
      "golangci-lint",
      "jq",
      "shfmt",
      "stylua",
      "yamlfmt"
    }
    local mason_registry = require("mason-registry")
    for _, package in ipairs(ensure_installed) do
      if not mason_registry.is_installed(package) then vim.cmd("MasonInstall " .. package) end
    end
  end,
  lazy = false
}
