return {
  "nvim-neotest/neotest",
  dependencies = {
    "orjangj/neotest-ctest",
  },
  config = function()
    local go_config = {
      runner = "gotestsum",
      gotestsum_args = { "--format=standard-verbose", "--format-icons=octicons" },
      go_test_args = { "-v" },
    }
    local python_config = {
      dap = { justMyCode = false },
      runner = "pytest",
      args = { "-vv", "-s", "-m", "integration or not integration" },
    }
    require("neotest").setup({
      icons = { passed = "", failed = "", running = "", skipped = "" },
      adapters = {
        require("neotest-ctest").setup({
          build_dir = vim.fn.getcwd() .. "/build/intraday-trading-api/test",
          is_test_file = function(file)
            return string.match(file, "_tests%.cpp$") ~= nil or string.match(file, "_test%.cpp$") ~= nil
          end,
        }),
        require("neotest-golang")(go_config),
        require("neotest-python")(python_config),
      },
    })
  end,
  keys = {
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>td",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Run nearest test with debug",
    },
    {
      "<leader>tb",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run current buffer",
    },
    {
      "<leader>ts",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Run entire test suite",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last test",
    },
    {
      "<leader>to",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },
    {
      "<leader>tp",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle summary panel",
    },
    {
      "<leader>tS",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stops test run",
    },
  },
}
