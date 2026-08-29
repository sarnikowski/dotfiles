-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Add any additional keymaps here
vim.keymap.set("n", "<S-x>", "<Cmd>:bd<CR>")

vim.keymap.set("n", "<leader>dk", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous Diagnostic" })

vim.keymap.set("n", "<leader>dj", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { noremap = true, silent = true, buffer = args.buf, desc = "LSP: References" }
    vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, opts)
  end,
})

vim.keymap.set("n", "<leader>at", "<Cmd>:Atlas<CR>")
