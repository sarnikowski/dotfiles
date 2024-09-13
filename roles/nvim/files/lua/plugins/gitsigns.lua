return {
  "lewis6991/gitsigns.nvim",
  event = "BufRead",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>hj",
      function()
        local gs = package.loaded.gitsigns
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gs.next_hunk() end)
        return "<Ignore>"
      end,
      expr = true,
      desc = "Next hunk"
    },
    {
      "<leader>hk",
      function()
        local gs = package.loaded.gitsigns
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
      end,
      expr = true,
      desc = "Previous hunk"
    },
    { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
    { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
    {
      "<leader>hs",
      function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      mode = "v",
      desc = "Stage hunk"
    },
    {
      "<leader>hr",
      function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      mode = "v",
      desc = "Reset hunk"
    },
    { "<leader>hS", function() require("gitsigns").stage_buffer() end, desc = "Stage buffer" },
    { "<leader>hu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo stage hunk" },
    { "<leader>hR", function() require("gitsigns").reset_buffer() end, desc = "Reset buffer" },
    { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
    { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame line" },
    { "<leader>tb", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle line blame" },
    { "<leader>hd", function() require("gitsigns").diffthis() end, desc = "Diff this" },
    { "<leader>hD", function() require("gitsigns").diffthis("~") end, desc = "Diff this ~" },
    { "<leader>htd", function() require("gitsigns").toggle_deleted() end, desc = "Toggle deleted" }
  }
}
