return {
  "crispgm/nvim-go",
  opts = {
    auto_format = false,
    auto_lint = false,
    linter = "golangci-lint",
    lint_prompt_style = "qf",
    formatter = "gofmt"
  },
  event = "BufRead"
}
