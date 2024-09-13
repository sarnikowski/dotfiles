return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
    "nvim-telescope/telescope-ui-select.nvim"
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local telescope_builtin = require("telescope.builtin")
    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case"
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = " ",
        initial_mode = "insert",
        sorting_strategy = "ascending",
        layout_config = { preview_width = 140 },
        layout_strategy = "bottom_pane",
        results_title = "",
        border = {},
        borderchars = {
          prompt = { "━", "", "", "", "━", "━", "", "" },
          results = { "", "", "", "", "", "", "", "" },
          preview = { "", "", "", "┃", "┃", "", "", "" }
        },
        pickers = { find_files = { find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" } } },
        set_env = { ["COLORTERM"] = "truecolor" },
        mappings = { i = { ["<esc>"] = actions.close } }
      }
    })
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
  keys = {
    { "<leader>ff", "<cmd>lua require('telescope.builtin').git_files()<cr>", desc = "Find git files" },
    { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Find buffers" },
    { "<leader>fg", "<cmd>lua require('telescope.builtin').git_commits()<cr>", desc = "Find git commits" },
    { "<leader>fl", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Code grep" },
    { "<leader>fs", "<cmd>lua require('telescope.builtin').search_history()<cr>", desc = "Search history" },
    { "<leader>fc", "<cmd>lua require('telescope.builtin').command_history()<cr>", desc = "Command history" },
    { "<leader>ft", "<cmd>lua require('telescope.builtin').treesitter()<cr>", desc = "Search treesitter" }
  }
}
