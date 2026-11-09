return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  init = function()
    -- The onedark comment grey (#5C6370) is nearly invisible on the line_insert
    -- background below. Brighten comments only inside CodeDiff windows via a
    -- window-local highlight namespace (links like @comment resolve through it).
    local ns = vim.api.nvim_create_namespace("codediff_readable_comments")
    vim.api.nvim_set_hl(ns, "Comment", { fg = "#9A93A3", italic = true })

    vim.api.nvim_create_autocmd("User", {
      pattern = { "CodeDiffOpen", "CodeDiffFileSelect" },
      callback = function(ev)
        local tab = ev.data and ev.data.tabpage or vim.api.nvim_get_current_tabpage()
        if not vim.api.nvim_tabpage_is_valid(tab) then
          return
        end
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
          vim.api.nvim_win_set_hl_ns(win, ns)
        end
      end,
    })
  end,
  opts = {
    highlights = {
      line_insert = "#2f4535",
      line_delete = "#3e2f36",
      char_insert = "#3f6146",
      char_delete = "#6b3b45",
    },
    diff = {
      compact_context_lines = 3, -- change to show more/less surrounding context
    },
    explorer = {
      line_stats = {
        enabled = true, -- Fetch and show Git line statistics
        count_untracked = false, -- Count untracked file lines as insertions
        max_untracked_bytes = 1024 * 1024, -- Skip larger untracked files
      },
    },
    keymaps = {
      explorer = {
        select = { "<CR>", "o" },
      },
    },
  },
}
