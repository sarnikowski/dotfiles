return {
  "Wansmer/treesj",
  event = "BufRead",
  opts = { use_default_keymaps = false },
  cmd = { "TSJToogle" },
  keys = { { "<leader>tt", "<cmd>TSJToggle<cr>", desc = "Toogle split/join for node under cursor" } }
}
