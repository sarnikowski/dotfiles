require("trouble").setup {
    use_diagnostic_signs = true,
    mode = "document_diagnostics"
}

vim.api.nvim_set_keymap("n", "<leader>tw",
                        "<cmd>LspTroubleToggle lsp_workspace_diagnostics<cr>",
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>td",
                        "<cmd>LspTroubleToggle lsp_document_diagnostics<cr>",
                        {silent = true, noremap = true})
