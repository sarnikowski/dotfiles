local map = vim.api.nvim_set_keymap
vim.g.mapleader = ","

-- Bufferline
map("n", "<S-t>", [[<Cmd>tabnew<CR>]], {silent = true}) -- new tab
map("n", "<S-x>", [[<Cmd>Bdelete<CR>]], {silent = true}) -- close tab
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], {silent = true})
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], {silent = true})

-- Nvimtree
vim.api.nvim_set_keymap("n", "<C-t>", ":NvimTreeToggle<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tf", ":NvimTreeFindFile<CR>",
                        {noremap = true, silent = true})

-- Telescope
vim.api.nvim_set_keymap("n", "<Leader>ff",
                        [[<Cmd>lua require('telescope.builtin').find_files()<CR>]],
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fb",
                        [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fg",
                        [[<Cmd>lua require('telescope.builtin').git_commits()<CR>]],
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fc",
                        [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]],
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fd", [[<Cmd>Telescope cder<CR>]],
                        {noremap = true, silent = true})

-- ISwap
vim.api.nvim_set_keymap("n", "<Leader>sw", [[<Cmd>ISwap<CR>]],
                        {noremap = true, silent = true})
