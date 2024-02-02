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

    -- Git diff
    DiffAdd = {bg = utils.darken(colors.sea_green, 0.30)},
    DiffChange = {bg = utils.darken(colors.yellow, 0.30)},
    DiffDelete = {bg = utils.darken(colors.light_red, 0.40)},

    -- Diffview
    GitSignsAdd = {fg = colors.green},
    GitSignsChange = {fg = colors.yellow},
    GitSignsDelete = {fg = colors.red},

    -- Neogit
    NeogitBranch = {fg = colors.purple},
    NeogitRemote = {fg = colors.cyan},
    NeogitHunkHeader = {bg = colors.bg_highlight, fg = colors.fg},
    NeogitHunkHeaderHighlight = {bg = colors.line_bg, fg = colors.blue},
    NeogitDiffContextHighlight = {
        bg = utils.darken(colors.bg, 0.80),
        fg = colors.fg_dark
    },
    NeogitDiffDeleteHighlight = {fg = colors.red},
    NeogitDiffAddHighlight = {fg = colors.green},

    -- Nvimtree
    NvimTreeFolderIcon = {fg = colors.blue},
    NvimTreeFolderName = {fg = colors.blue},
    NvimTreeIndentMarker = {fg = "#5c6370"},
    NvimTreeNormal = {bg = colors.bg},
    NvimTreeVertSplit = {fg = colors.line_bg},

    NvimTreeGitDirty = {fg = colors.orange},
    NvimTreeGitDeleted = {fg = colors.red},
    NvimTreeGitNew = {fg = colors.green},
    NvimTreeGitMerge = {fg = colors.yellow},
    NvimTreeGitStaged = {fg = "#C678DD"},
    NvimTreeGitRenamed = {fg = "#81A1C1"},

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
    FloatBorder = {guifg = white, guibg = white},
    CursorLinenr = {guifg = colors.fg}
}

for group, color in pairs(theme.base) do utils.set_color(group, color) end
