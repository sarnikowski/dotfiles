-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Custom onedark highlight overrides. The theme table lives in lua/config/highlights.lua;
-- plugins that register their own groups late re-apply it themselves (see lua/plugins/atlas.lua).
local highlights = require("config.highlights")

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("user_highlights", { clear = true }),
  pattern = "onedark",
  callback = highlights.apply,
  desc = "Set custom highlights after colorscheme loads",
})

highlights.apply()

-- LazyVim force-enables `spell` (and `wrap`) for every `markdown` buffer. That also
-- catches plugin-rendered markdown shown in scratch buffers (e.g. atlas.nvim PR
-- views), where the red SpellBad underlines are just noise. Turn it back off there.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_scratch_markdown", { clear = true }),
  pattern = "markdown",
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= "" then
      vim.opt_local.spell = false
    end
  end,
  desc = "Disable spell for non-file markdown buffers",
})
