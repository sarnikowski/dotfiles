vim.o.termguicolors = true

local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    api.config.mappings.default_on_attach(bufnr)
end

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and
            require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd("quit")
        end
    end
})

return {
    on_attach = on_attach,
    disable_netrw = true,
    open_on_tab = true,
    update_cwd = false,
    filters = {dotfiles = true},
    filesystem_watchers = {
      ignore_dirs = {
          "venv",
          ".venv",
          "node_modules",
          "__pycache__",
          ".mypy_cache",
          ".pytest_cache",
          ".cache",
      },
    },
    diagnostics = {
        enable = false,
        icons = {hint = "󰌵", info = "", warning = "", error = ""}
    },
    git = {enable = true, ignore = false, timeout = 500},
    view = {width = 30, side = "left"},
    renderer = {
        indent_markers = {
            enable = true,
            icons = {corner = "└", edge = "│ ", none = "  "}
        },
        highlight_git = true,
        root_folder_modifier = ":~",
        -- For some reason nvimtree treats these weirdly. This fixes the highlight problem.
        special_files = {"Makefile", "README.md"},
        icons = {
            show = {git = true, folder = true, file = true},
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌"
                },
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = ""
                }
            }
        }
    },
    actions = {
        open_file = {
            quit_on_open = false,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {filetype = {"notify", "packer", "qf"}}
            }
        }
    }
}
