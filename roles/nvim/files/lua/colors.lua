local utils = require("utils")

local colors = {
	bg = "#282C34",
	bg_highlight = utils.lighten("#282C34", 0.20),
	red = "#E06C75",
	green = "#98C379",
	yellow = "#E5C07B",
	orange = "#D19A66",
	blue = "#61AFEF",
	purple = "#C678DD",
	cyan = "#56B6C2",
	fg = "#ABB2BF",
	fg_dark = utils.darken("#ABB2BF", 0.75),

	light_red = "#F9929B",
	sea_green = "#7ECA9C",
	light_green = "#A3BE8C",
	dark_bg = "#1E222A",
	hint = "#B6BDCA",

	line_bg = "#1E222A",

	black = "#000000",
}
return colors
