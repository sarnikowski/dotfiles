local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
end

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then vim.cmd("quit") end
  end
})

return { -- File tree
  "nvim-tree/nvim-tree.lua",
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  opts = {
    on_attach = on_attach,
    disable_netrw = true,
    open_on_tab = true,
    filters = { dotfiles = true },
    filesystem_watchers = {
      ignore_dirs = { "venv", ".venv", "node_modules", "__pycache__", ".mypy_cache", ".pytest_cache", ".cache", ".git" }
    },
    diagnostics = { enable = false, icons = { hint = "󰌵", info = "", warning = "", error = "" } },
    view = { width = 30, side = "left" },
    renderer = {
      indent_markers = { enable = true, icons = { corner = "┗", edge = "┃ ", item = "┃ ", none = "  " } },
      highlight_git = true
    }
  },
  lazy = false,
  keys = {
    { "<C-t>", "<cmd>:NvimTreeToggle<cr>", desc = "Toogle nvim tree" },
    { "<leader>tf", "<cmd>:NvimTreeFindFile<cr>", desc = "Find buffer in nvim tree" }
  }
}
