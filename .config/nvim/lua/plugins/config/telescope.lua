local utils = require("utils")
local actions = require("telescope.actions")
require("telescope").setup {
    defaults = {
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case"
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = " ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_config = {preview_width = 140},
        layout_strategy = "bottom_pane",
        results_title = "",
        file_sorter = require"telescope.sorters".get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require"telescope.sorters".get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = {
            prompt = {"━", "", "", "", "━", "━", "", ""},
            results = {"", "", "", "", "", "", "", ""},
            preview = {"", "", "", "┃", "┃", "", "", ""}
        },
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require"telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require"telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require"telescope.previewers".vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require"telescope.previewers".buffer_previewer_maker,
        mappings = {i = {["<esc>"] = actions.close}}
    },
    extensions = {
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg" -- find command (defaults to `fd`)
        },
        cder = {
            previewer_command = "exa " .. "-a " .. "--color=always " .. "-T " ..
                "--level=3 " .. "--icons " .. "--git-ignore " .. "--long " ..
                "--no-permissions " .. "--no-user " .. "--no-filesize " ..
                "--git " .. "--ignore-glob=.git",
            dir_command = {"fd", "--type", ".", "/home/philip/projects"}
        }
    }
}
require('telescope').load_extension("fzf")
require('telescope').load_extension("cder")
require("telescope").load_extension("ui-select")
