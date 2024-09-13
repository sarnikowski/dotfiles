return { -- DAP
  "mfussenegger/nvim-dap",
  event = "BufReadPre",
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
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
    { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "DAP step into" },
    { "<leader>dn", "<cmd>lua require('dap').step_over()<cr>", desc = "DAP step over" },
    { "<leader>do", "<cmd>lua require('dap').step_out()<cr>", desc = "DAP step out" },
    { "<leader>b", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "DAP toogle breakpoint" },
    { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "DAP continue" },
    { "<leader>dC", "<cmd>lua require('dap').clear_breakpoints()<cr>", desc = "DAP clear all breakpoints" },
    { "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", desc = "DAP terminate" }
  }
}
