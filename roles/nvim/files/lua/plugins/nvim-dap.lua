return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    local dap = require("dap")
    dap.configurations = {
      go = {
        { type = "go", name = "Debug", request = "launch", program = "${file}" },
        {
          type = "go",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}"
        }
      },
      python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            if os.getenv("VIRTUAL_ENV") == nil then
              return os.getenv("VIRTUAL_ENV") .. "/bin/python"
            else
              return "/usr/bin/python"
            end
          end
        }
      }
    }

    dap.adapters.go = {
      type = "server",
      port = "${port}",
      executable = { command = vim.fn.stdpath("data") .. "/mason/bin/dlv", args = { "dap", "-l", "127.0.0.1:${port}" } }
    }
  end,
  keys = {
    { "<leader>di", function() require("dap").step_into() end, desc = "DAP step into" },
    { "<leader>dn", function() require("dap").step_over() end, desc = "DAP step over" },
    { "<leader>do", function() require("dap").step_out() end, desc = "DAP step out" },
    { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "DAP toggle breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "DAP continue" },
    { "<leader>dC", function() require("dap").clear_breakpoints() end, desc = "DAP clear all breakpoints" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "DAP terminate" }
  }
}
