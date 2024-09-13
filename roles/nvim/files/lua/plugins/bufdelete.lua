return {
  "famiu/bufdelete.nvim", -- Delete buffer without messing up window
  event = "VeryLazy",
  keys = { { "<S-x>", "<cmd>Bdelete<cr>", desc = "Delete buffer" } }
}
