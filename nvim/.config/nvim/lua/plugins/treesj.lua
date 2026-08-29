return {
  "Wansmer/treesj",
  opts = { use_default_keymaps = false },
  cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  keys = { { "<leader>tt", "<cmd>TSJToggle<cr>", desc = "Toggle split/join for node under cursor" } },
}
