return {
  "rcarriga/nvim-dap-ui",
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    require("dapui").setup({
      layouts = { { elements = { "scopes", "breakpoints", "stacks", "watches" }, size = 40, position = "left" } }
    })
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
  end,
  keys = { { "<leader>ds", function() require("dapui").toggle() end, desc = "Toogle DAP UI" } },
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
}
