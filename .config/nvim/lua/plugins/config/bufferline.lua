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
        fill = {fg = bar_fg, bg = bar_bg},
        background = {fg = bar_fg, bg = bar_bg},

        -- buffer
        buffer_selected = {
            fg = active_buffer_fg,
            bg = active_buffer_bg,
            bold = true
        },
        buffer_visible = {fg = visible_buffer_fg, bg = bar_bg},

        -- tabs over right
        tab = {fg = visible_buffer_fg, bg = bg},
        tab_close = {fg = tab_close_fg, bg = bar_bg},

        -- close button
        close_button = {fg = bar_fg, bg = bar_bg},
        close_button_visible = {fg = visible_buffer_fg, bg = bar_bg},
        close_button_selected = {
            fg = active_buffer_fg,
            bg = active_buffer_bg
        },

        -- buffer separators
        separator = {fg = bar_bg, bg = bar_bg},
        separator_selected = {fg = bar_bg, bg = bar_bg},
        separator_visible = {fg = bar_bg, bg = bar_bg},

        -- indicator
        indicator_selected = {fg = bar_bg, bg = bar_bg},

        -- modified files (but not saved)
        modified_selected = {
            fg = modified_selected_fg,
            bg = active_buffer_bg
        },
        modified_visible = {fg = modified_visible_fg, bg = "#23272f"}
    }
}
