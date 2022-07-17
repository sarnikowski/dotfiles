local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then scopes["o"][key] = value end
end

opt("o", "hidden", true)
opt("o", "ignorecase", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("w", "number", true)
opt("o", "numberwidth", 2)
opt("w", "cul", true)

opt("o", "mouse", "a")

opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 1)

opt("o", "updatetime", 250) -- update interval for gitsigns
opt("o", "clipboard", "unnamedplus")

-- for indentLine
opt("b", "shiftwidth", 4)
opt("b", "tabstop", 4)

-- Modifiable
opt("o", "modifiable", true)

opt("o", "list", true)

-- Hide stuff TODO map this with Lua
local cmd = vim.cmd

cmd "set noshowmode"
cmd "set noshowmatch"

-- Backup stuff
cmd "set nobackup"
cmd "set noswapfile"
cmd "set nowritebackup"

cmd "syntax on"

cmd "hi clear CursorLine"

vim.opt.listchars:append("tab:>-")
vim.g.mapleader = ","
