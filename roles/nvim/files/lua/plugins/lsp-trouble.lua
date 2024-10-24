return {
  "folke/lsp-trouble.nvim",
  event = "VeryLazy",
  config = function()
    require("trouble").setup({
      use_diagnostic_signs = true,
      mode = "document_diagnostics",
      auto_close = true,
      follow = false,
      modes = { diagnostics = { groups = { { "filename", format = "{file_icon} {basename:Title} {count}" } } } }
    })
  end,
  keys = {
    { "<leader>j", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>", desc = "Jump to next item" },
    {
      "<leader>k",
      "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>",
      desc = "Jump to previous item"
    },
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todo's in trouble" }
  }
}
