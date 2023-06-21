local present, mason = pcall(require, "mason")

if not present then
  return
end

local options = {
  lsps = {
    "bash-language-server",
    "dockerfile-language-server",
    "eslint-lsp",
    "gopls",
    "json-lsp",
    "prettier",
    "pyright",
    "rust-analyzer",
    "sqlls",
    "typescript-language-server",
    "vue-language-server",
    "yaml-language-server",
  },
  linters = {
    "flake8",
    "golangci-lint",
  },
  formatters = {
    "jq",
    "shfmt",
    "yamlfmt",
  },
  max_concurrent_installers = 10
}

mason.setup(options)
