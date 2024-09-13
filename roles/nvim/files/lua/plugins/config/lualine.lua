local colors = require("colors")

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end
}

-- Config
local config = {
    globalstatus = true,
    options = {
        disabled_filetypes = {
            "packer",
            "alpha",
            "NvimTree",
            "dap-repl",
            "dapui_breakpoints",
            "dapui_console",
            "dapui_scopes",
            "dapui_watches",
            "dapui_stacks",
        },
        -- Disable sections and component separators
        component_separators = "",
        section_separators = "",
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = {c = {fg = colors.fg, bg = colors.dark_bg}},
            inactive = {c = {fg = colors.fg, bg = colors.bg}}
        }
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {}
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_v = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {}
    }
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

local mode_aliases = {
    n = "NORMAL",
    i = "INSERT",
    c = "COMMAND",
    V = "VISUAL",
    [""] = "VISUAL",
    v = "VISUAL",
    R = "REPLACE"
}

ins_left({
    -- mode component
    function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.green,
            i = colors.blue,
            v = colors.purple,
            [""] = colors.blue,
            V = colors.purple,
            c = colors.purple,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.red,
            Rv = colors.purple,
            cv = colors.red,
            ce = colors.red,
            r = colors.red,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red
        }
        vim.api.nvim_command("hi! LualineMode gui=bold guifg=" ..
                                 mode_color[vim.fn.mode()] .. " guibg=" ..
                                 colors.dark_bg)
        return "󰊠  " .. mode_aliases[vim.fn.mode()]
    end,
    color = "LualineMode",
    padding = {left = 1, right = 1}
})

ins_left({"filetype", colored = true, icon_only = true})

ins_left({
    "filename",
    cond = conditions.buffer_not_empty,
    file_status = true,
    full_path = true,
    shorten = true,
    color = {fg = colors.magenta, gui = "bold"}
})

ins_left({"filesize", cond = conditions.buffer_not_empty})

ins_left({
    "diagnostics",
    sources = {"nvim_diagnostic"},
    symbols = {error = " ", warn = " ", info = " ", hint = "󰌵 "},
    diagnostics_color = {
        color_error = {fg = colors.light_red},
        color_warn = {fg = colors.yellow},
        color_info = {fg = colors.light_green},
        color_hint = {fg = colors.hint}
    }
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({function() return "%=" end})

ins_left({
    -- Lsp server name .
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then return msg end
        msg = ""
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                if msg == "" then
                    msg = client.name
                else
                    msg = msg .. ", " .. client.name
                end
            end
        end
        return msg
    end,
    icon = " LSP:",
    color = {fg = colors.fg, gui = "bold"},
    cond = conditions.hide_in_width
})

local function limit(input)
    input = string.lower(input)
    if vim.fn.winwidth(0) < 100 then
        limit = 10
    else
        limit = 20
    end
    if string.len(input) > limit then
        input = string.sub(input, 0, limit - 1) .. "..."
    end
    return input
end

ins_right({
    fmt = limit,
    "branch",
    icon = "",
    color = {fg = colors.purple, gui = "bold"},
    cond = conditions.hide_in_width
})

ins_right({"location", color = {fg = colors.fg, gui = "bold"}})

ins_right({"progress", color = {fg = colors.fg, gui = "bold"}})

ins_right({
    "diff",
    -- Is it me or the symbol for modified us really weird
    symbols = {added = " ", modified = "󰋒 ", removed = " "},
    diff_color = {
        added = {fg = colors.green},
        modified = {fg = colors.orange},
        removed = {fg = colors.red}
    },
    cond = conditions.hide_in_width
})
return config
