return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
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
