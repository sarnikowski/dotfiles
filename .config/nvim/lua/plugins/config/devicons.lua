local colors = require("colors")
require"nvim-web-devicons".setup {
    override = {
        Dockerfile = {icon = "", color = colors.cyan, name = "Dockerfile"},
        rb = {icon = "", color = "#ff75a0", name = "rb"},
        vue = {icon = "﵂", color = colors.light_green, name = "vue"},
        py = {icon = "", color = colors.yellow, name = "py"},
        toml = {icon = "", color = colors.blue, name = "toml"},
        zip = {icon = "", color = colors.yellow, name = "zip"},
        Makefile = {icon = "", color = colors.red, name = "Makefile"},
        bash = {icon = "", color = colors.sea_green, name = "Bash"},
        sh = {icon = "", color = colors.sea_green, name = "Sh"},
        pdf = {icon = "", color = colors.red, name = "Pdf"}
    },
    default = true
}
