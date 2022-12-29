local present, treesitter_cfgs = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

treesitter_cfgs.setup {
  ensure_installed = "all",
  highlight = {enable = true, use_languagetree = true},
}
