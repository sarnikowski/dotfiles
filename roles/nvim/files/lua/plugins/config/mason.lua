return {
    ensure_installed = {
        "bash-language-server", "dockerfile-language-server", "eslint-lsp",
        "gopls", "json-lsp", "lua-language-server", "prettier", "pyright",
        "rust-analyzer", "sqlls", "typescript-language-server",
        "vue-language-server", "yaml-language-server", "cpptools",
        "delve", "debugpy", "flake8", "golangci-lint", "jq", "shfmt",
        "stylua", "yamlfmt"
    },

    max_concurrent_installers = 10,
    automatic_installation = true,
    ensure_installed = ensure_installed
}
