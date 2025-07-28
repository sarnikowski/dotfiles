-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
local function hexToRgb(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  local r, g, b = string.match(hex_str, pat)
  return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
local function blend(fg, bg, alpha)
  bg = hexToRgb(bg)
  fg = hexToRgb(fg)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function darken(hex, amount, bg)
  return blend(hex, bg or "#000000", math.abs(amount))
end

local function lighten(hex, amount, fg)
  return blend(hex, fg or "#FFFFFF", math.abs(amount))
end

local function set_color(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"

  local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg
  vim.cmd(hl)
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local c = {
      bg = "#282C34",
      light_bg = lighten("#282C34", 0.95),
      dark_bg = "#1E222A",

      fg = "#ABB2BF",
      light_fg = darken("#ABB2BF", 0.75),
      dark_fg = darken("#ABB2BF", 0.75),

      red = "#E06C75",
      light_red = "#F9929B",
      dark_red = darken("#E06C75", 0.40),
      green = "#98C379",
      light_green = "#A3BE8C",
      dark_green = darken("#7ECA9C", 0.30),
      yellow = "#E5C07B",
      dark_yellow = darken("#E5C07B", 0.30),
      orange = "#D19A66",
      blue = "#61AFEF",
      dark_blue = darken("#61AFEF", 0.30),
      purple = "#C678DD",
      cyan = "#56B6C2",

      black = "#000000",

      hint = "#B6BDCA",
      comment = "#5C6370",
    }

    local theme = {
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
      GitSignsChange = { fg = c.yellow },
      GitSignsChangeLn = { fg = c.yellow },
      GitSignsChangeNr = { fg = c.yellow },
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

      --Neotree
      NeoTreeDimText = { fg = darken(c.fg, 0.95) },
      NeoTreeFileName = { fg = c.fg },
      NeoTreeGitModified = { fg = c.orange },
      NeoTreeGitStaged = { fg = c.green },
      NeoTreeGitUntracked = { fg = c.red },

      -- LSP
      DiagnosticError = { fg = c.light_red }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticWarning = { fg = c.orange }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticInformation = { fg = c.light_green }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)

      DiagnosticUnderlineError = { fg = c.light_red, style = "underline" },
      DiagnosticUnderlineWarning = { fg = c.orange, style = "underline" },
      DiagnosticUnderlineInformation = { fg = c.light_green, style = "underline" },
      DiagnosticUnderlineHint = { fg = c.hint, style = "underline" },

      DiagnosticVirtualTextError = { bg = lighten(c.bg, 0.95), fg = c.light_red }, -- Used for "Error" diagnostic virtual text
      DiagnosticVirtualTextWarning = { bg = lighten(c.bg, 0.95), fg = c.orange }, -- Used for "Warning" diagnostic virtual text
      DiagnosticVirtualTextInformation = { bg = lighten(c.bg, 0.95), fg = c.light_green }, -- Used for "Information" diagnostic virtual text
      DiagnosticVirtualTextHint = { bg = lighten(c.bg, 0.95), fg = c.hint }, -- Used for "Hint" diagnostic virtual text

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
      ["@variable.parameter"] = { fg = c.red },
      ["@variable.member"] = { fg = c.red },
      ["@module.go"] = { fg = c.fg },

      -- Trouble
      TroubleSelected = { bg = c.light_bg },

      -- General
      Comment = { fg = c.comment, style = "italic" },
      CursorLine = { bg = c.light_bg },
      CursorLinenr = { fg = c.orange, style = "bold" },
      EndOfBuffer = { fg = c.line_bg },
      FloatBorder = { fg = c.orange, bg = darken(c.bg, 0.90), style = "bold" },
      LineNr = { fg = c.comment },
      NormalFloat = { bg = darken(c.bg, 0.90) },
      Pmenu = { bg = darken(c.bg, 0.90) },
      PmenuSel = { fg = c.black, bg = c.blue },
      StatusLineNC = { fg = c.comment },
      VertSplit = { fg = c.comment },
      WinBar = { fg = c.fg, bg = c.bg },
      WinBarNC = { fg = c.fg, bg = c.bg },
      WinSeparator = { fg = c.dark_fg },
      NonText = { fg = c.comment },
    }

    for group, color in pairs(theme) do
      set_color(group, color)
    end
  end,
  desc = "Set custom highlights after colorscheme loads",
})
vim.cmd("doautocmd ColorScheme")
