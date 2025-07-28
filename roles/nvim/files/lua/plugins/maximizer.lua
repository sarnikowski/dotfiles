return {
  "0x00-ketsu/maximizer.nvim",
  config = function()
    require("maximizer").setup({})
  end,
  keys = {
    {
      "<leader>m",
      function()
        require("maximizer").toggle()
      end,
      desc = "Toogle maximize buffer",
    },
  },
}
