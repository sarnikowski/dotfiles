return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "fredrikaverpil/neotest-golang",
    "alfaix/neotest-gtest",
    "nvim-neotest/neotest-python"
  },
  config = function()
    require("neotest").setup({
      icons = { passed = "", failed = "", running = "", skipped = "" },
      adapters = {
        require("neotest-golang"),
        require("neotest-gtest").setup({ is_test_file = function(file) return vim.endswith(file, "_tests.cpp") end }),
        require("neotest-python")({ dap = { justMyCode = false }, runner = "pytest", args = { "-vv" } })
      }
    })
  end,
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
    {
      "<leader>td",
      function() require("neotest").run.run({ strategy = "dap" }) end,
      desc = "Run nearest test with debug"
    },
    { "<leader>tb", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current buffer" },
    { "<leader>ts", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run entire test suite" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
    { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
    { "<leader>tp", function() require("neotest").summary.toggle() end, desc = "Toggle summary panel" },
    { "<leader>tm", function() require("neotest").mark.toggle() end, desc = "Toggle test mark" },
    { "<leader>tu", function() require("neotest").mark.clear() end, desc = "Clear all test marks" }
  }
}
