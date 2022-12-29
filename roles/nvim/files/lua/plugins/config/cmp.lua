local present, cmp = pcall(require, "cmp")

if not present then
  return
end

cmp.setup {
    autocomplete = cmp.TriggerEvent.TextChanged,
    sources = {
        {name = "nvim_lsp"}, {name = "nvim_lua"}, {name = "treesitter"},
        {name = "buffer"}, {name = "path"}, {name = "calc"}
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-c>"] = cmp.mapping.close(),
        ["<C-space>"] = cmp.mapping.complete()
    }),
    preselect = cmp.PreselectMode.Item,
    formatting = {
        fields = {"kind", "abbr", "menu"},
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.menu = vim_item.kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind]
            return vim_item
        end
    }
}

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}, {name = 'cmdline'}}),
    mapping = cmp.mapping.preset.cmdline({})
})
