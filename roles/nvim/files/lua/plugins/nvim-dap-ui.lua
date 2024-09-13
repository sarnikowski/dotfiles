return {
  "rcarriga/nvim-dap-ui",
  opts = { layouts = { elements = { "scopes", "breakpoints", "stacks", "watches" }, size = 40, position = "left" } },
  keys = { { "<leader>ds", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toogle DAP UI" } },
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
}
