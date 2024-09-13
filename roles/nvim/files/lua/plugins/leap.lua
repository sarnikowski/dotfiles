return {
  "ggandor/leap.nvim",
  event = "BufEnter",
  config = function()
    local leap = require("leap")
    leap.setup({ leap.set_default_keymaps(true) })
  end
}
