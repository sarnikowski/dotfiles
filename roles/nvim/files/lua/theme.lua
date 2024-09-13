local cmd = vim.cmd
cmd("colorscheme onedark")

local colors = require("colors")
local utils = require("utils")

local theme = {}

theme.base = {
    -- Cmp
    CmpItemKindText = {fg = colors.fg},
    CmpItemKindMethod = {fg = colors.blue},
    CmpItemKindFunction = {fg = colors.blue},
    CmpItemKindConstructor = {fg = colors.yellow},
    CmpItemKindField = {fg = colors.blue},
    CmpItemKindClass = {fg = colors.yellow},
    CmpItemKindInterface = {fg = colors.yellow},
    CmpItemKindModule = {fg = colors.blue},
    CmpItemKindProperty = {fg = colors.blue},
    CmpItemKindValue = {fg = colors.orange},
    CmpItemKindEnum = {fg = colors.yellow},
    CmpItemKindKeyword = {fg = colors.purple},
    CmpItemKindSnippet = {fg = colors.green},
    CmpItemKindFile = {fg = colors.blue},
    CmpItemKindEnumMember = {fg = colors.cyan},
    CmpItemKindConstant = {fg = colors.orange},
    CmpItemKindStruct = {fg = colors.yellow},
    CmpItemKindTypeParameter = {fg = colors.yellow},

    -- DAP
    DapBreakpoint = {fg = colors.red},
    DapLogPoint = {fg = colors.green},
    DapStopped = {fg = colors.green},
    DapUINormal = {fg = colors.fg},
    DapUIPlayPause = {fg = colors.green},
    DapUIRestart = {fg = colors.yellow},
    DapUIStepBack = {fg = colors.cyan},
    DapUIStepInto = {fg = colors.purple},
    DapUIStepOut = {fg = colors.green},
    DapUIStepOver = {fg = colors.cyan},
    DapUIStop = {fg = colors.red},
    DapUIUnavailable = {fg = colors.gray},

    DapUIBreakpointsCurrentLine = {fg = colors.green},
    DapUIBreakpointsInfo = {fg = colors.green},
    DapUIBreakpointsPath = {fg = colors.blue},
    DapUIDecoration = {fg = colors.blue},
    DapUIFloatBorder = {fg = colors.blue},
    DapUILineNumber = {fg = colors.cyan},
    DapUIModifiedValue = {fg = colors.cyan},
    DapUIScope = {fg = colors.blue},
    DapUIStoppedThread = {fg = colors.cyan},
    DapUIThread = {fg = colors.green},
    DapUIWatchesEmpty = {fg = colors.red},
    DapUIWatchesError = {fg = colors.red},
    DapUIWatchesValue = {fg = colors.green},

    -- Git diff
    DiffAdd = {bg = colors.dark_green},
    DiffChange = {bg = colors.dark_yellow},
    DiffDelete = {bg = colors.dark_red},

    -- Diffview
    GitSignsAdd = {fg = colors.green},
    GitSignsChange = {fg = colors.yellow},
    GitSignsDelete = {fg = colors.red},

    -- Neogit
    NeogitBranch = {fg = colors.purple},
    NeogitRemote = {fg = colors.cyan},
    NeogitHunkHeader = {bg = colors.light_bg, fg = colors.fg},
    NeogitHunkHeaderHighlight = {bg = colors.line_bg, fg = colors.blue},
    NeogitDiffContextHighlight = {
        bg = utils.darken(colors.bg, 0.80),
        fg = colors.dark_fg
    },
    NeogitDiffDeleteHighlight = {fg = colors.red},
    NeogitDiffAddHighlight = {fg = colors.green},

    -- Nvimtree
    NvimTreeFolderIcon = {fg = colors.blue},
    NvimTreeFolderName = {fg = colors.blue},
    NvimTreeIndentMarker = {fg = "#5c6370"},
    NvimTreeNormal = {bg = colors.bg},
    NvimTreeVertSplit = {fg = colors.line_bg},
    NvimTreeStatusLineNC = {fg = colors.fg},
    NvimTreeStatusLine = {fg = colors.fg},

    NvimTreeGitDirty = {fg = colors.orange},
    NvimTreeGitDeleted = {fg = colors.red},
    NvimTreeGitNew = {fg = colors.green},
    NvimTreeGitMerge = {fg = colors.yellow},
    NvimTreeGitStaged = {fg = "#C678DD"},
    NvimTreeGitRenamed = {fg = "#81A1C1"},

    -- Trouble
    TroubleSelected = {bg = colors.light_bg},

    -- LSP
    DiagnosticError = {fg = colors.light_red}, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarning = {fg = colors.orange}, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInformation = {fg = colors.light_green}, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint = {fg = colors.hint}, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)

    DiagnosticUnderlineError = {fg = colors.light_red, style = "underline"},
    DiagnosticUnderlineWarning = {fg = colors.orange, style = "underline"},
    DiagnosticUnderlineInformation = {
        fg = colors.light_green,
        style = "underline"
    },
    DiagnosticUnderlineHint = {fg = colors.hint, style = "underline"},

    DiagnosticVirtualTextError = {
        bg = utils.lighten(colors.bg, 0.95),
        fg = colors.light_red
    }, -- Used for "Error" diagnostic virtual text
    DiagnosticVirtualTextWarning = {
        bg = utils.lighten(colors.bg, 0.95),
        fg = colors.orange
    }, -- Used for "Warning" diagnostic virtual text
    DiagnosticVirtualTextInformation = {
        bg = utils.lighten(colors.bg, 0.95),
        fg = colors.light_green
    }, -- Used for "Information" diagnostic virtual text
    DiagnosticVirtualTextHint = {
        bg = utils.lighten(colors.bg, 0.95),
        fg = colors.hint
    }, -- Used for "Hint" diagnostic virtual text

    -- Treesitter
    ["@constructor"] = {fg = colors.cyan},
    ["@function.builtin"] = {fg = colors.cyan},
    ["@keyword"] = {fg = colors.purple},
    ["@keyword.function"] = {fg = colors.purple},
    ["@namespace"] = {fg = colors.fg},
    ["@parameter"] = {fg = colors.orange},
    ["@type.builtin"] = {fg = colors.cyan},
    ["@variable"] = {fg = colors.fg},
    ["@variable.member"] = {fg = colors.red},
    ["@module.go"] = {fg = colors.fg},

    -- General
    LineNr = {fg = "#5C6370"},
    Comment = {fg = "#5C6370"},
    VertSplit = {fg = "#5C6370"},
    StatusLineNC = {fg = "#5C6370"},
    EndOfBuffer = {fg = colors.line_bg},
    PmenuSel = {fg = colors.black, bg = colors.blue},
    Pmenu = {bg = utils.lighten(colors.bg, 0.95)},
    NormalFloat = {bg = white},
    FloatBorder = {fg = white, bg = white},
    CursorLinenr = {fg = colors.fg},
    CursorLine = {bg = colors.light_bg},
    WinBar = {fg = colors.fg, bg = colors.light_bg},
    WinBarNC = {fg = colors.fg, bg = colors.light_bg}
}

for group, color in pairs(theme.base) do utils.set_color(group, color) end
