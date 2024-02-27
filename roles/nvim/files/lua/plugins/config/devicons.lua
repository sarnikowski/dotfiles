local colors = require("colors")
return {
    override = {
        vue = {icon = "󰡄", color = "#42B883", name = "vue"},
        py = {icon = "", color = colors.yellow, name = "py"},
        toml = {icon = "", color = colors.cyan, name = "toml"},
        Makefile = {icon = "", color = colors.red, name = "makefile"},
        bash = {icon = "", color = colors.sea_green, name = "bash"},
        sh = {icon = "", color = colors.sea_green, name = "sh"},
        pdf = {icon = "", color = colors.red, name = "pdf"},
        [".gitignore"] = {icon = "", color = "#F34F29", name = "GitIgnore"},
        [".gitattributes"] = {
            icon = "",
            color = "#F34F29",
            name = "GitAttributes"
        },
        [".git-blame-ignore-revs"] = {
            icon = "",
            color = "#F34F29",
            name = "GitBlameIgnoreRevs"
        },
        [".envrc"] = {icon = "", color = colors.yellow, name = "Envrc"}
    },
    default = true
}
