return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
    ensure_installed = {
      "bash-language-server",
      "cpptools",
      "debugpy",
      "debugpy",
      "delve",
      "dockerfile-language-server",
      "golangci-lint",
      "gopls",
      "jq",
      "json-lsp",
      "lua-language-server",
      "prettier",
      "pyright",
      "ruff-lsp",
      "rust-analyzer",
      "shfmt",
      "sqlls",
      "stylua",
      "typescript-language-server",
      "vue-language-server",
      "yaml-language-server",
      "yamlfmt"
    }
    local mason_registry = require("mason-registry")
    for _, package in ipairs(ensure_installed) do
      if not mason_registry.is_installed(package) then vim.cmd("MasonInstall " .. package) end
    end
  end,
  lazy = false
}
