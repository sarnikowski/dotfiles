local present, nvim_tree = pcall(require, "nvim-tree")

if not present then
  return
end

local utils = require("utils")
local g = vim.g

vim.o.termguicolors = true
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

g.nvim_tree_allow_resize = 1

nvim_tree.setup {
    disable_netrw = true,
    open_on_tab = true,
    update_cwd = false,
    filters = {dotfiles = true},
    diagnostics = {
        enable = false,
        icons = {hint = "", info = "", warning = "", error = ""}
    },
    git = {enable = true, ignore = false, timeout = 500},
    view = {
        width = 30,
        side = 'left',
        mappings = {
            custom_only = false,
            list = {
                {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
                {key = {"<leader>cd"}, cb = tree_cb("cd")},
                {key = "s", cb = tree_cb("vsplit")},
                {key = "i", cb = tree_cb("split")},
                {key = "<C-t>", cb = tree_cb("tabnew")},
                {key = "<", cb = tree_cb("prev_sibling")},
                {key = ">", cb = tree_cb("next_sibling")},
                {key = "P", cb = tree_cb("parent_node")},
                {key = "<BS>", cb = tree_cb("close_node")},
                {key = "<S-CR>", cb = tree_cb("close_node")},
                {key = "<Tab>", cb = tree_cb("preview")},
                {key = "K", cb = tree_cb("first_sibling")},
                {key = "J", cb = tree_cb("last_sibling")},
                {key = "I", cb = tree_cb("toggle_ignored")},
                {key = "H", cb = tree_cb("toggle_dotfiles")},
                {key = "R", cb = tree_cb("refresh")},
                {key = "a", cb = tree_cb("create")},
                {key = "d", cb = tree_cb("remove")},
                {key = "r", cb = tree_cb("rename")},
                {key = "<C-r>", cb = tree_cb("full_rename")},
                {key = "x", cb = tree_cb("cut")},
                {key = "c", cb = tree_cb("copy")},
                {key = "p", cb = tree_cb("paste")},
                {key = "y", cb = tree_cb("copy_name")},
                {key = "Y", cb = tree_cb("copy_path")},
                {key = "gy", cb = tree_cb("copy_absolute_path")},
                {key = "[c", cb = tree_cb("prev_git_item")},
                {key = "]c", cb = tree_cb("next_git_item")},
                {key = "u", cb = tree_cb("dir_up")},
                {key = "q", cb = tree_cb("close")},
                {key = "g?", cb = tree_cb("toggle_help")}
            }
        }
    },
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
