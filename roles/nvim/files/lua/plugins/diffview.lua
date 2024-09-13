function DiffviewToogle()
  local view = require("diffview.lib").get_current_view()
  if view then
    vim.cmd(":DiffviewClose")
    vim.cmd(":NvimTreeToggle")
  else
    if require("nvim-tree.view").is_visible() then vim.cmd(":NvimTreeToggle") end
    vim.cmd(":DiffviewOpen")
  end
end

return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  keys = { { "<leader>dv", "<cmd>:lua DiffviewToogle()<cr>", desc = "Toogle diffview" } }
}
