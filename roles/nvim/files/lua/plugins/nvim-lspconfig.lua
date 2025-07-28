return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers.gopls = {
      settings = {
        gopls = {
          hints = {
            assignVariableTypes = false,
            compositeLiteralFields = false,
            compositeLiteralTypes = false,
            constantValues = false,
            functionTypeParameters = false,
            parameterNames = false,
            rangeVariableTypes = false,
          },
        },
      },
    }
    opts.servers.basedpyright = {
      settings = {
        basedpyright = {
          -- Using Ruff's import organizer
          disableOrganizeImports = true,
          typeCheckingMode = "recommended",
          analysis = {
            diagnosticSeverityOverrides = {
              reportAny = false,
              -- reportMissingTypeArgument = false,
              reportMissingParameterType = false,
              reportUnknownArgumentType = false,
              reportUnknownLambdaType = false,
              reportUnknownMemberType = false,
              reportUnknownParameterType = false,
              reportUnknownVariableType = false,
              reportUnusedCallResult = false,
            },
          },
        },
      },
    }
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<leader>re", "<cmd>lua vim.lsp.buf.references()<CR>" }
    keys[#keys + 1] = { "<leader>ch", "<cmd>lua vim.lsp.buf.signature_help()<CR>" }
    keys[#keys + 1] = { "<leader>dk", "<cmd>lua vim.diagnostic.goto_prev()<CR>" }
    keys[#keys + 1] = { "<leader>dj", "<cmd>lua vim.diagnostic.goto_next()<CR>" }
  end,
}
