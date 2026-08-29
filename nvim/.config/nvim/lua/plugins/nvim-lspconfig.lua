return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics.virtual_text = false -- We use tiny-inline-diagnostic for this.
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
    opts.inlay_hints = { enabled = false }
  end,
}
