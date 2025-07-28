return {
  "stevearc/conform.nvim",
  event = "BufEnter",
  opts = {
    formatters_by_ft = {
      json = { "jq" },
    },
    formatters = {
      jq = {
        args = { "--indent", "4", "." },
      },
    },
  },
}
