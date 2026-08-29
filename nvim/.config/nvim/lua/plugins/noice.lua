return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    presets = {
      lsp_doc_border = true,
    },
    views = {
      -- noice's hover view defaults to `border.padding = { 0, 2 }`, which draws a
      -- wide NormalFloat band inside the rounded border. Tighten it to one column.
      hover = {
        border = {
          padding = { 0, 1 },
        },
      },
    },
  },
}
