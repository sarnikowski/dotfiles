vim.cmd("colorscheme onedark")

local c = require("colors")
local utils = require("utils")

-- Colors and style
theme = {
  -- Cmp
  CmpItemKindText = { fg = c.fg },
  CmpItemKindMethod = { fg = c.blue },
  CmpItemKindFunction = { fg = c.blue },
  CmpItemKindConstructor = { fg = c.yellow },
  CmpItemKindField = { fg = c.blue },
  CmpItemKindClass = { fg = c.yellow },
  CmpItemKindInterface = { fg = c.yellow },
  CmpItemKindModule = { fg = c.blue },
  CmpItemKindProperty = { fg = c.blue },
  CmpItemKindValue = { fg = c.orange },
  CmpItemKindEnum = { fg = c.yellow },
  CmpItemKindKeyword = { fg = c.purple },
  CmpItemKindSnippet = { fg = c.green },
  CmpItemKindFile = { fg = c.blue },
  CmpItemKindEnumMember = { fg = c.cyan },
  CmpItemKindConstant = { fg = c.orange },
  CmpItemKindStruct = { fg = c.yellow },
  CmpItemKindTypeParameter = { fg = c.yellow },

  -- DAP
  DapBreakpoint = { fg = c.red },
  DapLogPoint = { fg = c.green },
  DapStopped = { fg = c.green },
  DapUINormal = { fg = c.fg },
  DapUIPlayPause = { fg = c.green },
  DapUIRestart = { fg = c.yellow },
  DapUIStepBack = { fg = c.cyan },
  DapUIStepInto = { fg = c.purple },
  DapUIStepOut = { fg = c.green },
  DapUIStepOver = { fg = c.cyan },
  DapUIStop = { fg = c.red },
  DapUIUnavailable = { fg = c.gray },

  DapUIBreakpointsCurrentLine = { fg = c.green },
  DapUIBreakpointsInfo = { fg = c.green },
  DapUIBreakpointsPath = { fg = c.blue },
  DapUIDecoration = { fg = c.blue },
  DapUIFloatBorder = { fg = c.blue },
  DapUILineNumber = { fg = c.cyan },
  DapUIModifiedValue = { fg = c.cyan },
  DapUIScope = { fg = c.blue },
  DapUIStoppedThread = { fg = c.cyan },
  DapUIThread = { fg = c.green },
  DapUIWatchesEmpty = { fg = c.red },
  DapUIWatchesError = { fg = c.red },
  DapUIWatchesValue = { fg = c.green },

  -- Diffview
  GitSignsAdd = { fg = c.green },
  GitSignsAddLn = { fg = c.green },
  GitSignsAddNr = { fg = c.green },
  GitSignsChange = { fg = c.blue },
  GitSignsChangeLn = { fg = c.blue },
  GitSignsChangeNr = { fg = c.blue },
  GitSignsDelete = { fg = c.red },
  GitSignsDeleteLn = { fg = c.red },
  GitSignsDeleteNr = { fg = c.red },

  -- Git diff
  DiffAdd = { bg = c.dark_green },
  DiffChange = { bg = c.dark_yellow },
  DiffDelete = { bg = c.dark_red },

  -- Neotest
  NeotestAdapterName = { fg = c.purple, style = "bold" },
  NeotestDir = { fg = c.cyan },
  NeotestExpandMarker = { fg = c.light_fg },
  NeotestFailed = { fg = c.red },
  NeotestFile = { fg = c.cyan },
  NeotestFocused = { style = "bold,italic" },
  NeotestIndent = { fg = c.light_fg },
  NeotestMarked = { fg = c.orange, style = "bold" },
  NeotestNamespace = { fg = c.blue },
  NeotestPassed = { fg = c.green },
  NeotestRunning = { fg = c.blue },
  NeotestWinSelect = { fg = c.cyan, style = "bold" },
  NeotestSkipped = { fg = c.light_fg },
  NeotestTarget = { fg = c.purple },
  NeotestTest = { fg = c.fg },
  NeotestUnknown = { fg = c.light_fg },

  -- NvimTree
  NvimTreeFolderIcon = { fg = c.blue },
  NvimTreeFolderName = { fg = c.blue },
  NvimTreeIndentMarker = { fg = c.comment },
  NvimTreeNormal = { bg = c.bg },
  NvimTreeVertSplit = { fg = c.line_bg },
  NvimTreeRootFolder = { fg = c.blue, style = "bold" },
  NvimTreeStatusLineNC = { fg = c.fg },
  NvimTreeStatusLine = { fg = c.fg },
  NvimTreeSymlink = { fg = c.blue },

  NvimTreeGitDeletedIcon = { fg = c.red },
  NvimTreeGitDirtyIcon = { fg = c.yellow },
  NvimTreeGitMergeIcon = { fg = c.cyan },
  NvimTreeGitNewIcon = { fg = c.green },

  -- LSP
  DiagnosticError = { fg = c.light_red }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticWarning = { fg = c.orange }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticInformation = { fg = c.light_green }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)

  DiagnosticUnderlineError = { fg = c.light_red, style = "underline" },
  DiagnosticUnderlineWarning = { fg = c.orange, style = "underline" },
  DiagnosticUnderlineInformation = { fg = c.light_green, style = "underline" },
  DiagnosticUnderlineHint = { fg = c.hint, style = "underline" },

  DiagnosticVirtualTextError = { bg = utils.lighten(c.bg, 0.95), fg = c.light_red }, -- Used for "Error" diagnostic virtual text
  DiagnosticVirtualTextWarning = { bg = utils.lighten(c.bg, 0.95), fg = c.orange }, -- Used for "Warning" diagnostic virtual text
  DiagnosticVirtualTextInformation = { bg = utils.lighten(c.bg, 0.95), fg = c.light_green }, -- Used for "Information" diagnostic virtual text
  DiagnosticVirtualTextHint = { bg = utils.lighten(c.bg, 0.95), fg = c.hint }, -- Used for "Hint" diagnostic virtual text

  -- Lualine
  LualineDiagnosticError = { style = "bold" },
  LualineDiagnosticWarn = { style = "bold" },
  LualineDiagnosticInfo = { style = "bold" },
  LualineDiagnosticHint = { style = "bold" },

  -- Treesitter
  ["@constructor"] = { fg = c.cyan },
  ["@function.builtin"] = { fg = c.cyan },
  ["@keyword"] = { fg = c.purple },
  ["@keyword.function"] = { fg = c.purple },
  ["@namespace"] = { fg = c.fg },
  ["@parameter"] = { fg = c.orange },
  ["@type.builtin"] = { fg = c.cyan },
  ["@variable"] = { fg = c.fg },
  ["@variable.member"] = { fg = c.red },
  ["@module.go"] = { fg = c.fg },

  -- Trouble
  TroubleSelected = { bg = c.light_bg },

  -- General
  LineNr = { fg = c.comment },
  Comment = { fg = c.comment },
  VertSplit = { fg = c.comment },
  StatusLineNC = { fg = c.comment },
  EndOfBuffer = { fg = c.line_bg },
  PmenuSel = { fg = c.black, bg = c.blue },
  Pmenu = { bg = utils.lighten(c.bg, 0.95) },
  NormalFloat = { bg = white },
  FloatBorder = { fg = white, bg = white },
  CursorLinenr = { fg = c.orange, style = "bold" },
  CursorLine = { bg = c.light_bg },
  WinBar = { fg = c.fg, bg = c.bg },
  WinBarNC = { fg = c.fg, bg = c.bg },
  WinSeparator = { fg = c.dark_fg }
}

for group, color in pairs(theme) do utils.set_color(group, color) end

-- Signs
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition",
                   { text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵"
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarning",
      [vim.diagnostic.severity.INFO] = "DiagnosticInformation",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint"
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarning",
      [vim.diagnostic.severity.INFO] = "DiagnosticInformation",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint"
    }
  }
}
