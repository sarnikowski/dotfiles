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
    "typescript-language-server",
    "vetur-vls",
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

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(options.lsps, " "))
  vim.cmd("MasonInstall " .. table.concat(options.linters, " "))
  vim.cmd("MasonInstall " .. table.concat(options.formatters, " "))
end, {})
