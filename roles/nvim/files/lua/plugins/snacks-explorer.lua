return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      enabled = true,
    },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          tree = true,
          win = {
            list = {
              keys = {
                ["<BS>"] = "explorer_up",
                ["l"] = "confirm",
                ["h"] = "explorer_close",
                ["a"] = "explorer_add",
                ["d"] = "explorer_del",
                ["r"] = "explorer_rename",
                ["c"] = "explorer_copy",
                ["m"] = "explorer_move",
                ["o"] = "confirm",
                ["P"] = "toggle_preview",
                ["y"] = { "explorer_yank", mode = { "n", "x" } },
                ["p"] = "explorer_paste",
                ["u"] = "explorer_update",
                ["<c-c>"] = "tcd",
                ["<leader>/"] = "picker_grep",
                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",
              },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>ft",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>fT",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer Snacks (cwd)",
    },
    { "<C-t>", "<leader>ft", desc = "Explorer Snacks (root dir)", remap = true },
    { "<C-t>", "<leader>fT", desc = "Explorer Snacks (cwd)", remap = true },
  },
}
