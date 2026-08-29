local function parse_test_args(input_str)
  local args = {}
  -- Split by space, preserving quoted strings
  for arg in input_str:gmatch("%S+") do
    table.insert(args, arg)
  end

  return args
end

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }
    dap.configurations.cpp = {
      {
        name = "Debug Test",
        type = "codelldb",
        request = "launch",
        program = function()
          local executable = os.getenv("CPP_TEST_EXECUTABLE")
          if not executable then
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
          end
          if not vim.startswith(executable, "/") then
            executable = vim.fn.getcwd() .. "/" .. executable
          end
          return executable
        end,
        cwd = "${workspaceFolder}",
        sourceLanguages = { "cpp" },
        args = function()
          local args = vim.fn.input("Test args: ")
          return parse_test_args(args)
        end,
      },
    }
    dap.defaults.fallback.exception_breakpoints = {}
  end,
}
