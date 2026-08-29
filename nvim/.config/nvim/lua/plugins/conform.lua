return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = {},
      json = { "jq" },
    },
    formatters = {
      jq = {
        args = { "--indent", "4", "." },
      },
    },
  },
}
