return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      parser_install_dir = "$HOME/.local/share/treesitter",
      highlight = { enable = true }
    })
  end
}
