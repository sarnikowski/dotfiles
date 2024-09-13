return {
  "mizlan/iswap.nvim",
  event = "BufRead",
  config = function() require("iswap").setup() end,
  keys = { { "<leader>sw", "<cmd>ISwap<cr>", desc = "Swap arguments" } }
}
