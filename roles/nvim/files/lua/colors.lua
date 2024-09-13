local utils = require("utils")

local colors = {
  bg = "#282C34",
  light_bg = utils.lighten("#282C34", 0.95),
  dark_bg = "#1E222A",

  fg = "#ABB2BF",
  light_fg = utils.darken("#ABB2BF", 0.75),
  dark_fg = utils.darken("#ABB2BF", 0.75),

  red = "#E06C75",
  light_red = "#F9929B",
  dark_red = utils.darken("#E06C75", 0.40),
  green = "#98C379",
  light_green = "#A3BE8C",
  dark_green = utils.darken("#7ECA9C", 0.30),
  yellow = "#E5C07B",
  dark_yellow = utils.darken("#E5C07B", 0.30),
  orange = "#D19A66",
  blue = "#61AFEF",
  dark_blue = utils.darken("#61AFEF", 0.30),
  purple = "#C678DD",
  cyan = "#56B6C2",

  black = "#000000",

  hint = "#B6BDCA",
  comment = "#5C6370"
}
return colors
