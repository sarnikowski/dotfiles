local colors = require("colors")

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

local function limit(input)
  input = string.lower(input)
  if vim.fn.winwidth(0) < 100 then
    limit = 10
  else
    limit = 20
  end
  if string.len(input) > limit then input = string.sub(input, 0, limit - 1) .. "..." end
  return input
end

local mode_aliases = {
  n = "NORMAL",
  i = "INSERT",
  c = "COMMAND",
  V = "VISUAL",
  [""] = "VISUAL",
  v = "VISUAL",
  R = "REPLACE"
}

return {
  "nvim-lualine/lualine.nvim",
  config = {
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
        "dapui_stacks"
      },
      component_separators = "",
      section_separators = "",
      theme = {
        normal = { c = { fg = colors.fg, bg = colors.dark_bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg } }
      }
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {
        {
          function()
            local mode_color = {
              n = colors.green,
              i = colors.blue,
              v = colors.purple,
              [""] = colors.blue,
              V = colors.purple,
              c = colors.purple,
              no = colors.red,
              s = colors.orange,
              S = colors.orange,
              [""] = colors.orange,
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
            vim.api.nvim_command("hi! LualineMode gui=bold guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" ..
                                     colors.dark_bg)
            return "󰊠  " .. mode_aliases[vim.fn.mode()]
          end,
          color = "LualineMode",
          padding = { left = 1, right = 1 }
        },
        { "filetype", colored = true, icon_only = true },
        {
          "filename",
          cond = conditions.buffer_not_empty,
          file_status = true,
          full_path = true,
          shorten = true,
          color = { fg = colors.magenta, gui = "bold" }
        },
        { "filesize", cond = conditions.buffer_not_empty, color = { gui = "bold" } },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " }
        },
        { function() return "%=" end },
        {
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
          icon = " LSP:",
          color = { fg = colors.fg, gui = "bold" },
          cond = conditions.hide_in_width
        }
      },
      lualine_x = {
        {
          fmt = limit,
          "branch",
          icon = "",
          color = { fg = colors.purple, gui = "bold" },
          cond = conditions.hide_in_width
        },
        { "location", color = { fg = colors.fg, gui = "bold" } },
        { "progress", color = { fg = colors.fg, gui = "bold" } },
        {
          "diff",
          symbols = { added = " ", modified = "󰋒 ", removed = " " },
          diff_color = {
            added = { fg = colors.green, gui = "bold" },
            modified = { fg = colors.orange, gui = "bold" },
            removed = { fg = colors.red, gui = "bold" }
          },
          cond = conditions.hide_in_width
        }
      }
    },
    inactive_sections = { lualine_a = {}, lualine_v = {}, lualine_y = {}, lualine_z = {}, lualine_c = {}, lualine_x = {} }
  },
  lazy = false
}
