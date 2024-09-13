-- General options
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.numberwidth = 2
vim.o.mouse = "a"
vim.o.cmdheight = 1
vim.o.updatetime = 250 -- update interval for gitsigns
vim.o.clipboard = "unnamedplus"
vim.o.modifiable = true
vim.o.list = true
vim.opt.laststatus = 3

-- Window-specific options
vim.wo.number = true
vim.wo.cul = true
vim.wo.signcolumn = "yes"

-- Buffer-specific options
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

-- Hide stuff
vim.opt.showmode = false
vim.opt.showmatch = false

-- Backup settings
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- Enable syntax highlighting
vim.cmd("syntax on")

-- Set listchars and fillchars
vim.opt.listchars:append("tab:>-")
vim.opt.fillchars:append("diff:/")

-- Hide tilde on empty lines
vim.opt.fillchars:append("eob: ")

-- Set leader key
vim.g.mapleader = ","

-- Setup floating window border
local border = {
  { "┏", "FloatBorder" },
  { "━", "FloatBorder" },
  { "┓", "FloatBorder" },
  { "┃", "FloatBorder" },
  { "┛", "FloatBorder" },
  { "━", "FloatBorder" },
  { "┗", "FloatBorder" },
  { "┃", "FloatBorder" }
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Install lazyvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error("Error cloning lazy.nvim:\n" .. out) end
end
vim.opt.rtp:prepend(lazypath)

-- Have to add the runtime path for treesitter, otherwise the parses are reinstalled
-- on every startup.
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/3605
vim.opt.runtimepath:prepend("$HOME/.local/share/treesitter")
require("lazy").setup({
  require("plugins.alpha-nvim"),
  require("plugins.auto-save"),
  require("plugins.bufdelete"),
  require("plugins.comment"),
  require("plugins.cutlass"),
  require("plugins.devicons"),
  require("plugins.diffview"),
  require("plugins.gitsigns"),
  require("plugins.indent-blankline"),
  require("plugins.iswap"),
  require("plugins.leap"),
  require("plugins.lsp-trouble"),
  require("plugins.lualine"),
  require("plugins.markview"),
  require("plugins.mason"),
  require("plugins.neotest"),
  require("plugins.nvim-autopairs"),
  require("plugins.nvim-cmp"),
  require("plugins.nvim-dap-python"),
  require("plugins.nvim-dap-ui"),
  require("plugins.nvim-dap-virtual-text"),
  require("plugins.nvim-dap"),
  require("plugins.nvim-go"),
  require("plugins.nvim-lspconfig"),
  require("plugins.nvim-surround"),
  require("plugins.nvim-tree"),
  require("plugins.nvim-treesitter"),
  require("plugins.onedark"),
  require("plugins.telescope"),
  require("plugins.tiny-devicons-auto-colors"),
  require("plugins.treesj"),
  require("plugins.vim-sleuth"),
  require("plugins.which-key")
})
-- For some reason we need to do this export after lazy has run again...
vim.opt.runtimepath:prepend("$HOME/.local/share/treesitter")

require("theme")
