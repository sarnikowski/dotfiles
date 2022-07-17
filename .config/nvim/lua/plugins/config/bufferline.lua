-- define some colors
local colors = require("colors")

local bar_bg = colors.bg
local bar_fg = "#565C64"
local active_buffer_fg = "#C8CCD4"
local active_buffer_bg = "#1E222a"
local visible_buffer_fg = "#9298A0"

local modified_visible_fg = colors.red
local modified_selected_fg = colors.green
local tab_close_fg = colors.light_red

require"bufferline".setup {
    options = {
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = " ",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "padded-slant"
    },

    -- bar colors
    highlights = {
        fill = {guifg = bar_fg, guibg = bar_bg},
        background = {guifg = bar_fg, guibg = bar_bg},

        -- buffer
        buffer_selected = {
            guifg = active_buffer_fg,
            guibg = active_buffer_bg,
            gui = "bold"
        },
        buffer_visible = {guifg = visible_buffer_fg, guibg = bar_bg},

        -- tabs over right
        tab = {guifg = visible_buffer_fg, guibg = bg},
        tab_close = {guifg = tab_close_fg, guibg = bar_bg},

        -- close button
        close_button = {guifg = bar_fg, guibg = bar_bg},
        close_button_visible = {guifg = visible_buffer_fg, guibg = bar_bg},
        close_button_selected = {
            guifg = active_buffer_fg,
            guibg = active_buffer_bg
        },

        -- buffer separators
        separator = {guifg = bar_bg, guibg = bar_bg},
        separator_selected = {guifg = bar_bg, guibg = bar_bg},
        separator_visible = {guifg = bar_bg, guibg = bar_bg},

        -- indicator
        indicator_selected = {guifg = bar_bg, guibg = bar_bg},

        -- modified files (but not saved)
        modified_selected = {
            guifg = modified_selected_fg,
            guibg = active_buffer_bg
        },
        modified_visible = {guifg = modified_visible_fg, guibg = "#23272f"}
    }
}
