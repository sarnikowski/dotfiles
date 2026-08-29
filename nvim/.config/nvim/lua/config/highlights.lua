-- Custom highlight overrides layered on top of the `onedark` colorscheme.
-- `M.apply()` is idempotent; call it again after any plugin that registers its
-- own groups late (see lua/plugins/atlas.lua).

local M = {}

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

-- Apply one highlight spec on top of the group's current definition.
-- Spec keys: fg / bg / sp (hex strings), style ("bold,italic,underline,strikethrough"), link.
local function set_hl(group, spec)
  if spec.link then
    vim.api.nvim_set_hl(0, group, { link = spec.link })
    return
  end

  local hl = vim.api.nvim_get_hl(0, { name = group }) --[[@as vim.api.keyset.highlight]]
  hl.link = nil
  hl.fg = spec.fg or hl.fg
  hl.bg = spec.bg or hl.bg
  hl.sp = spec.sp or hl.sp
  for _, attr in ipairs(vim.split(spec.style or "", ",", { trimempty = true })) do
    hl[attr] = true
  end

  vim.api.nvim_set_hl(0, group, hl)
end

function M.apply()
  if vim.g.colors_name ~= "onedark" then
    return
  end

  local c = {
    bg = "#282C34",
    light_bg = lighten("#282C34", 0.95),
    dark_bg = "#1E222A",
    bg2 = "#393F4A", -- navarasu/onedark.nvim `bg2`, used for word/reference highlights

    fg = "#ABB2BF",
    light_fg = darken("#ABB2BF", 0.75),

    red = "#E06C75",
    light_red = "#F9929B",
    dark_red = darken("#E06C75", 0.40),
    green = "#98C379",
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
    -- Atlas
    AtlasTextPositive = { fg = c.green, style = "bold" },
    AtlasTextWarning = { fg = c.yellow, style = "bold" },
    AtlasTextNote = { fg = c.purple, style = "bold" },
    AtlasTextMuted = { fg = c.comment },
    AtlasTextMutedItalic = { fg = c.comment, style = "italic" },
    AtlasTextMutedStrikethrough = { fg = c.comment, style = "strikethrough" },

    -- Structure
    AtlasBorder = { fg = c.comment },
    AtlasColumnHeader = { fg = c.comment, style = "bold" },
    AtlasSectionHeader = { fg = c.comment, style = "bold,underline" },
    AtlasTabInactive = { link = "CursorLine" },

    -- Log levels
    AtlasLogInfo = { fg = c.blue, style = "bold" },
    AtlasLogWarn = { fg = c.yellow, style = "bold" },
    AtlasLogError = { fg = c.red, style = "bold" },

    -- Footer bar (dark_bg as the footer background)
    AtlasFooterBackground = { bg = c.dark_bg },
    AtlasFooterText = { fg = c.comment, bg = c.dark_bg },
    AtlasFooterInfo = { fg = c.blue, bg = c.dark_bg, style = "bold" },
    AtlasFooterSuccess = { fg = c.green, bg = c.dark_bg, style = "bold" },
    AtlasFooterWarning = { fg = c.yellow, bg = c.dark_bg, style = "bold" },
    AtlasFooterError = { fg = c.red, bg = c.dark_bg, style = "bold" },
    AtlasFooterNote = { fg = c.purple, bg = c.dark_bg, style = "bold" },

    -- Chips
    AtlasChipActive = { fg = c.black, bg = c.blue, style = "bold" },

    -- Diff overlays
    AtlasDiffAddLine = { link = "DiffAdd" },
    AtlasDiffRemoveLine = { link = "DiffDelete" },
    AtlasDiffChangeLine = { link = "DiffChange" },
    AtlasDiffDeleteFiller = { link = "Comment" },

    -- Pipelines
    AtlasPipelineLinkSuccess = { fg = c.green },
    AtlasPipelineLinkFailed = { fg = c.red },
    AtlasPipelineLinkInProgress = { fg = c.yellow },
    AtlasPipelineLinkMuted = { fg = c.comment },

    -- Generic PR status (Bitbucket/GitLab)
    AtlasPROpen = { fg = c.green },
    AtlasPRDraft = { fg = c.yellow },
    AtlasPRMerged = { fg = c.blue },
    AtlasPRDeclined = { fg = c.red },
    AtlasPROpenChip = { fg = c.black, bg = c.green, style = "bold" },
    AtlasPRDraftChip = { fg = c.black, bg = c.yellow, style = "bold" },
    AtlasPRMergedChip = { fg = c.black, bg = c.blue, style = "bold" },
    AtlasPRDeclinedChip = { fg = c.black, bg = c.red, style = "bold" },

    -- GitHub-specific PR chips (keeps GitHub's own semantics: green/grey/red/purple)
    AtlasGitHubTheme = { fg = c.fg, bg = c.bg, style = "bold" },
    AtlasGitHubPROpen = { fg = c.black, bg = c.green, style = "bold" },
    AtlasGitHubPRDraft = { fg = c.black, bg = c.comment, style = "bold" },
    AtlasGitHubPRClosed = { fg = c.black, bg = c.red, style = "bold" },
    AtlasGitHubPRMerged = { fg = c.black, bg = c.purple, style = "bold" },

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
    DapUIUnavailable = { fg = c.comment },

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

    -- LSP -- Info stays blue (onedark's own): noice borders / cmdline icon / search
    -- count [1/4] all link to the DiagnosticInfo family.
    DiagnosticError = { fg = c.light_red },
    DiagnosticWarn = { fg = c.orange },
    DiagnosticInfo = { fg = c.blue },
    DiagnosticHint = { fg = c.hint },

    DiagnosticUnderlineError = { fg = c.light_red, style = "underline" },
    DiagnosticUnderlineWarn = { fg = c.orange, style = "underline" },
    DiagnosticUnderlineInfo = { fg = c.blue, style = "underline" },
    DiagnosticUnderlineHint = { fg = c.hint, style = "underline" },

    DiagnosticVirtualTextError = { bg = lighten(c.bg, 0.95), fg = c.light_red },
    DiagnosticVirtualTextWarn = { bg = lighten(c.bg, 0.95), fg = c.orange },
    DiagnosticVirtualTextInfo = { bg = lighten(c.bg, 0.95), fg = c.blue },
    DiagnosticVirtualTextHint = { bg = lighten(c.bg, 0.95), fg = c.hint },

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
    ["@lsp.type.namespace.go"] = { fg = c.fg },
    ["@string.go"] = { fg = c.green },

    -- Trouble
    TroubleSelected = { bg = c.light_bg },

    -- Search: onedark's own yellow for matches, orange + bold for the current one
    Search = { fg = c.bg, bg = c.yellow }, -- non-current matches
    IncSearch = { fg = c.bg, bg = c.orange, style = "bold" }, -- incremental / replace
    CurSearch = { fg = c.bg, bg = c.orange, style = "bold" }, -- current match

    -- Word / symbol under cursor (colors taken from navarasu/onedark.nvim)
    LspReferenceText = { bg = c.bg2 },
    LspReferenceRead = { bg = c.bg2 },
    LspReferenceWrite = { bg = c.bg2 },
    IlluminatedWordText = { bg = c.bg2, style = "bold" },
    IlluminatedWordRead = { bg = c.bg2, style = "bold" },
    IlluminatedWordWrite = { bg = c.bg2, style = "bold" },

    -- snacks.nvim windows + picker. snacks defines all of these with `default = true`
    -- on first use, so setting them here takes precedence. Border bg matches the
    -- editor so no dark box shows around the rounded corners.
    SnacksNormal = { bg = c.bg },
    SnacksNormalNC = { bg = c.bg },
    SnacksWinBar = { fg = c.fg, bg = c.bg },
    SnacksWinBarNC = { fg = c.fg, bg = c.bg },
    SnacksPicker = { bg = c.bg },
    SnacksPickerNormal = { bg = c.bg },
    SnacksPickerBorder = { fg = c.orange, bg = c.bg },
    SnacksPickerInputBorder = { fg = c.orange, bg = c.bg },
    SnacksPickerListBorder = { fg = c.orange, bg = c.bg },
    SnacksPickerPreviewBorder = { fg = c.orange, bg = c.bg },
    SnacksPickerBoxBorder = { fg = c.orange, bg = c.bg },
    SnacksPickerTitle = { fg = c.bg, bg = c.orange, style = "bold" },
    SnacksPickerInputTitle = { fg = c.bg, bg = c.orange, style = "bold" },
    SnacksPickerPreviewTitle = { fg = c.bg, bg = c.orange, style = "bold" },
    SnacksPickerBoxTitle = { fg = c.bg, bg = c.orange, style = "bold" },
    SnacksPickerInputSearch = { fg = c.purple },
    SnacksPickerMatch = { fg = c.orange, style = "bold" },
    SnacksPickerSelected = { fg = c.purple, style = "bold" },
    SnacksPickerDir = { fg = c.comment },
    SnacksPickerPathHidden = { fg = c.comment },
    SnacksPickerPathIgnored = { fg = c.comment },

    -- fzf-lua. Same story: fzf-lua links these to `Normal` with `default = true` on
    -- every ColorScheme, so an explicit definition here wins. `FzfLuaBorder` defaults
    -- to the grey `Normal` fg -- give it the orange border like every other float.
    FzfLuaNormal = { bg = c.bg },
    FzfLuaBorder = { fg = c.orange, bg = c.bg },
    FzfLuaTitle = { fg = c.bg, bg = c.orange, style = "bold" },
    FzfLuaPreviewNormal = { bg = c.bg },
    FzfLuaPreviewBorder = { fg = c.orange, bg = c.bg },
    FzfLuaPreviewTitle = { fg = c.bg, bg = c.orange, style = "bold" },
    FzfLuaFzfMatch = { fg = c.orange, style = "bold" },
    FzfLuaFzfPrompt = { fg = c.purple },
    FzfLuaFzfPointer = { fg = c.red },
    FzfLuaHeaderBind = { fg = c.orange },
    FzfLuaHeaderText = { fg = c.green },

    -- General
    Comment = { fg = c.comment, style = "italic" },
    CursorLine = { bg = c.light_bg },
    CursorLineNr = { fg = c.orange, style = "bold" },
    EndOfBuffer = { fg = c.bg },
    FloatBorder = { fg = c.orange, bg = c.bg },
    LineNr = { fg = c.comment },
    NormalFloat = { bg = c.bg },
    Pmenu = { bg = darken(c.bg, 0.90) },
    PmenuSel = { fg = c.black, bg = c.blue },
    StatusLineNC = { fg = c.comment },
    VertSplit = { fg = c.comment },
    WinBar = { fg = c.fg, bg = c.bg },
    WinBarNC = { fg = c.fg, bg = c.bg },
    WinSeparator = { fg = c.light_fg },
    NonText = { fg = c.comment },
  }

  for group, spec in pairs(theme) do
    set_hl(group, spec)
  end
end

return M
