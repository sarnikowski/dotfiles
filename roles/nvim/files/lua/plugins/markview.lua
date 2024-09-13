return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  config = function() vim.opt.runtimepath:prepend("$HOME/.local/share/treesitter") end,
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }
}
