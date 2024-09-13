local c = require("colors")
return {
  "nvim-tree/nvim-web-devicons",
  opts = {
    override = {
      vue = { icon = "󰡄", color = c.green, name = "vue" },
      toml = { icon = "", color = c.blue, name = "toml" },
      Makefile = { icon = "", color = c.red, name = "makefile" },
      bash = { icon = "", color = c.green, name = "bash" },
      sh = { icon = "", color = c.green, name = "sh" },
      [".gitignore"] = { icon = "", color = c.red, name = "GitIgnore" },
      [".gitattributes"] = { icon = "", color = c.red, name = "GitAttributes" },
      [".git-blame-ignore-revs"] = { icon = "", color = c.red, name = "GitBlameIgnoreRevs" },
      [".envrc"] = { icon = "", color = c.yellow, name = "Envrc" }
    }
  },
  lazy = true
}
