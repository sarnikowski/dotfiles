local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

function DiffviewToogle()
    local view = require("diffview.lib").get_current_view()
    if view then
        vim.cmd(":DiffviewClose")
        vim.cmd(":NvimTreeToggle")
    else
        if require("nvim-tree.view").is_visible() then
            vim.cmd(":NvimTreeToggle")
        end
        vim.cmd(":DiffviewOpen")
    end
end

-- Have to add the runtime path for treesitter, otherwise the parses are reinstalled
-- on every startup.
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/3605
vim.opt.runtimepath:prepend("$HOME/.local/share/treesitter")

require("lazy").setup({
    {"joshdick/onedark.vim", lazy = false, priority = 1000}, {
        "williamboman/mason.nvim",
        opts = require("plugins.config.mason"),
        lazy = false
    }, {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                parser_install_dir = "$HOME/.local/share/treesitter",
                highlight = {enable = true}
            })
        end
    }, { -- LSP
        "neovim/nvim-lspconfig",
        lazy = false,
        keys = {
            {"<leader>rs", "<cmd>LspRestart<cr>", desc = "Restart LSP server"}
        }
    }, {
        "folke/lsp-trouble.nvim",
        event = "VeryLazy",
        config = function()
            require("trouble").setup({
                use_diagnostic_signs = true,
                mode = "document_diagnostics",
                auto_close = true,
                icons = {
                  indent = {
                    middle = " ",
                    last = " ",
                    top = " ",
                    ws = "│  ",
                  },
                },
                modes = {
                  diagnostics = {
                    groups = {
                      { "filename", format = "{file_icon} {basename:Title} {count}" },
                    },
                  },
                },
            })
        end,
        keys = {
            { "<leader>j", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>", desc = "Jump to next item."},
            { "<leader>k", "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>", desc = "Jump to previous item."},
            { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
            { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
            { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
            { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
            { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
        }
    },
    {"crispgm/nvim-go", opts = require("plugins.config.go"), event = "BufRead"},
    {
        "nvim-lualine/lualine.nvim",
        config = require("plugins.config.lualine"),
        lazy = false
    }, { -- DAP
        "mfussenegger/nvim-dap",
        event = "BufReadPre",
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            local sign = vim.fn.sign_define

            sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
            sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
            sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
            sign('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

            dap.configurations = {
                go = {
                  {
                    type = "go",
                    name = "Debug",
                    request = "launch",
                    program = "${file}",
                  },
                  {
                    type = "go",
                    name = "Debug test (go.mod)",
                    request = "launch",
                    mode = "test",
                    program = "./${relativeFileDirname}",
                  },
              }
            }
            dap.adapters.go = {
              type = "server",
              port = "${port}",
              executable = {
                command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
                args = { "dap", "-l", "127.0.0.1:${port}" },
              },
            }
        end,
        keys = {
            {
                "<leader>di",
                "<cmd>lua require('dap').step_into()<cr>",
                desc = "DAP step into"
            },
            {
                "<leader>dn",
                "<cmd>lua require('dap').step_over()<cr>",
                desc = "DAP step over"
            },
            {
                "<leader>do",
                "<cmd>lua require('dap').step_out()<cr>",
                desc = "DAP step out"
            }, {
                "<leader>b",
                "<cmd>lua require('dap').toggle_breakpoint()<cr>",
                desc = "DAP toogle breakpoint"
            }, {
                "<leader>dc",
                "<cmd>lua require('dap').continue()<cr>",
                desc = "DAP continue"
            }, {
                "<leader>dC",
                "<cmd>lua require('dap').clear_breakpoints()<cr>",
                desc = "DAP clear all breakpoints"
            }, {
                "<leader>dt",
                "<cmd>lua require('dap').terminate()<cr>",
                desc = "DAP terminate"
            }
        }
    }, {
        "rcarriga/nvim-dap-ui",
        config = true,
        keys = {
            {
                "<leader>ds",
                "<cmd>lua require('dapui').toggle()<cr>",
                desc = "Toogle DAP UI"
            }
        },
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text"}
    }, { -- Git
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = require("plugins.config.gitsigns")
    }, {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = function()
            local cb = require("diffview.config").diffview_callback
            require("diffview").setup({
                diff_binaries = false, -- Show diffs for binaries
                enhanced_diff_hl = false,
                file_panel = {win_config = {width = 35}},
                key_bindings = {
                    disable_defaults = false, -- Disable the default key bindings
                    -- The `view` bindings are active in the diff buffers, only when the current
                    -- tabpage is a Diffview.
                    view = {
                        ["<tab>"] = cb("select_next_entry"), -- Open the diff for the next file
                        ["<s-tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
                        ["<leader>e"] = cb("focus_files"), -- Bring focus to the files panel
                        ["<leader>b"] = cb("toggle_files") -- Toggle the files panel.
                    },
                    file_panel = {
                        ["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
                        ["<down>"] = cb("next_entry"),
                        ["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
                        ["<up>"] = cb("prev_entry"),
                        ["<cr>"] = cb("select_entry"), -- Open the diff for the selected entry.
                        ["o"] = cb("select_entry"),
                        ["<2-LeftMouse>"] = cb("select_entry"),
                        ["-"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
                        ["S"] = cb("stage_all"), -- Stage all entries.
                        ["U"] = cb("unstage_all"), -- Unstage all entries.
                        ["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
                        ["<tab>"] = cb("select_next_entry"),
                        ["<s-tab>"] = cb("select_prev_entry"),
                        ["<leader>e"] = cb("focus_files"),
                        ["<leader>b"] = cb("toggle_files")
                    }
                }
            })
        end,
        keys = {
            {
                "<leader>dv",
                "<cmd>:lua DiffviewToogle()<cr>",
                desc = "Toogle diffview"
            }
        }
    }, -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                autocomplete = require("cmp").TriggerEvent.TextChanged,
                sources = {
                    {name = "nvim_lsp"}, {name = "nvim_lua"},
                    {name = "treesitter"}, {name = "buffer"}, {name = "path"},
                    {name = "calc"}
                },
                mapping = require("cmp").mapping.preset.insert({
                    ["<C-c>"] = require("cmp").mapping.close(),
                    ["<C-space>"] = require("cmp").mapping.complete()
                }),
                preselect = require("cmp").PreselectMode.Item,
                formatting = {
                    fields = {"kind", "abbr", "menu"},
                    format = function(_, vim_item)
                        -- fancy icons and a name of kind
                        vim_item.menu = vim_item.kind
                        vim_item.kind =
                            require("lspkind").presets.default[vim_item.kind]
                        return vim_item
                    end
                }
            })
        end
    }, { -- Autocompletion
        "hrsh7th/nvim-cmp",
        opts = require("plugins.config.cmp"),
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip", "onsails/lspkind-nvim", "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-calc", "ray-x/cmp-treesitter",
            "saadparwaiz1/cmp_luasnip"
        }
    }, { -- File tree
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                opts = require("plugins.config.devicons")
            }
        },
        opts = require("plugins.config.nvimtree"),
        lazy = false,
        keys = {
            {"<C-t>", "<cmd>:NvimTreeToggle<cr>", desc = "Toogle nvim tree"},
            {
                "<leader>tf",
                "<cmd>:NvimTreeFindFile<cr>",
                desc = "Find buffer in nvim tree"
            }
        }
    }, { -- Telescope
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim", {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
            }, "nvim-telescope/telescope-ui-select.nvim"
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg", "--color=never", "--no-heading",
                        "--with-filename", "--line-number", "--column",
                        "--smart-case"
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
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = {},
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
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
                    file_previewer = require("telescope.previewers").vim_buffer_cat
                        .new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep
                        .new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist
                        .new,
                    -- Developer configurations: Not meant for general override
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                    mappings = {i = {["<esc>"] = actions.close}}
                }
            })
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
        keys = {
            {
                "<leader>ff",
                "<cmd>lua require('telescope.builtin').git_files()<cr>",
                desc = "Find git files"
            }, {
                "<leader>fb",
                "<cmd>lua require('telescope.builtin').buffers()<cr>",
                desc = "Find buffers"
            }, {
                "<leader>fg",
                "<cmd>lua require('telescope.builtin').git_commits()<cr>",
                desc = "Find git commits"
            }, {
                "<leader>fl",
                "<cmd>lua require('telescope.builtin').live_grep()<cr>",
                desc = "Code grep"
            }, {
                "<leader>fs",
                "<cmd>lua require('telescope.builtin').search_history()<cr>",
                desc = "Search history"
            }, {
                "<leader>fc",
                "<cmd>lua require('telescope.builtin').command_history()<cr>",
                desc = "Command history"
            }, {
                "<leader>ft",
                "<cmd>lua require('telescope.builtin').treesitter()<cr>",
                desc = "Search treesitter"
            }
        }
    }, { -- Stabilized windows
        "luukvbaal/stabilize.nvim",
        lazy = false,
        config = function() require("stabilize").setup() end
    }, { -- Movement
        "ggandor/leap.nvim",
        event = "BufEnter",
        config = function()
            local leap = require("leap")
            leap.setup({leap.set_default_keymaps(true)})
        end
    }, { -- Paranthesis/pairs
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() 
            -- local autopairs = require("nvim-autopairs").setup()
            -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            -- local cmp = require("cmp")
            -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    }, {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function() require("nvim-surround").setup() end
    }, { -- Swap arguments
        "mizlan/iswap.nvim",
        event = "BufRead",
        keys = {{"<leader>sw", "<cmd>ISwap<cr>", desc = "Swap arguments"}},
        config = function() require("iswap").setup() end
    }, { -- Split/join code blocks
        "Wansmer/treesj",
        event = "BufRead",
        cmd = {"TSJToogle", "TSJSplit", "TSJJoin"},
        keys = {
            {
                "<leader>tt",
                "<cmd>TSJToggle<cr>",
                desc = "Toogle split/join for node under cursor"
            },
            {
                "<leader>ts",
                "<cmd>TSJSplit<cr>",
                desc = "Split node under cursor"
            },
            {"<leader>tj", "<cmd>TSJJoin<cr>", desc = "Join node under cursor"}
        },
        opts = {use_default_keymaps = false}
    }, { -- Markdown
        "iamcco/markdown-preview.nvim",
        event = "VeryLazy",
        build = "cd app && npm install",
        config = function() vim.g.mkdp_auto_close = 0 end
    }, { -- Indentation
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter",
        main = "ibl",
        opts = {
            indent = {char = " "},
            scope = {show_start = false, show_end = false}
        }
    }, {"tpope/vim-sleuth", event = "BufEnter"}, -- Autoconfigure indentation type based on other files
    { -- Startup screen
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("alpha").setup(require("alpha.themes.startify").opts)
        end
    }, -- Misc
    {"Pocco81/auto-save.nvim", event = "VeryLazy"},
    {"tpope/vim-commentary", event = "BufEnter"}, {
        "famiu/bufdelete.nvim", -- Delete buffer without messing up window
        event = "VeryLazy",
        keys = {{"<S-x>", "<cmd>Bdelete<cr>", desc = "Delete buffer"}}
    }, { -- Everything goes to black hole register by default
        "gbprod/cutlass.nvim",
        event = "BufEnter",
        config = function() require("cutlass").setup({cut_key = "m"}) end
    }
})

vim.opt.runtimepath:prepend("$HOME/.local/share/treesitter")
