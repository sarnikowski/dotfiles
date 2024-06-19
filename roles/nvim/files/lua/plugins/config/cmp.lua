local source_mapping = {
    nvim_lsp = "[LSP]",
    nvim_lua = "[LUA]",
    luasnip = "[SNIP]",
    buffer = "[BUF]",
    path = "[PATH]",
    treesitter = "[TREE]"
}

local config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    cmp.setup({
        preselect = require("cmp").PreselectMode.Item,
        keyword_length = 2,
        snippet = {expand = function(args) vim.snippet.expand(args.body) end},
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        autocomplete = require("cmp").TriggerEvent.TextChanged,
        view = {
            entries = {
                name = "custom",
                selection_order = "near_cursor",
                follow_cursor = true
            }
        },
        mapping = require("cmp").mapping.preset.insert({
            ["<C-q>"] = require("cmp").mapping.abort(),
            ["<C-space>"] = require("cmp").mapping.complete()
        }),
        sources = cmp.config.sources({
            {
                name = "luasnip",
                group_index = 1,
                option = {use_show_condition = true},
                entry_filter = function()
                    local context = require("cmp.config.context")
                    return not context.in_treesitter_capture("string") and
                               not context.in_syntax_group("String")
                end
            }, {name = "nvim_lsp", group_index = 2},
            {name = "nvim_lua", group_index = 3},
            {name = "crates", group_index = 3},
            {name = "treesitter", keyword_length = 4, group_index = 4},
            {name = "path", keyword_length = 4, group_index = 4}, {
                name = "buffer",
                keyword_length = 3,
                group_index = 5,
                option = {
                    get_bufnrs = function()
                        local bufs = {}
                        for _, win in ipairs(vim.api.nvim_list_wins()) do
                            bufs[vim.api.nvim_win_get_buf(win)] = true
                        end
                        return vim.tbl_keys(bufs)
                    end
                }
            }
        }),
        formatting = {
            format = function(_, vim_item)
                -- fancy icons and a name of kind
                vim_item.menu = vim_item.kind
                vim_item.kind = lspkind.presets.default[vim_item.kind]
                return vim_item
            end,
            mode = "symbol_text",
            ellipsis_char = "...",
            menu = source_mapping
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                cmp.config.compare.offset, cmp.config.compare.exact,
                cmp.config.compare.score, cmp.config.compare.recently_used,
                cmp.config.compare.locality, cmp.config.compare.kind,
                cmp.config.compare.sort_text, cmp.config.compare.length,
                cmp.config.compare.order
            }
        },
        experimental = {native_menu = false, ghost_text = false}
    })
end
return config
