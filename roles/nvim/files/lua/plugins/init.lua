local packer = require("packer")
local use = packer.use

return require("packer").startup(function()
    use "wbthomason/packer.nvim"
    use {
        "williamboman/mason.nvim",
        config = require "plugins.config.mason"
    }

    use "nvim-lua/plenary.nvim" -- Used by telescope, gitsigns, neogit

    -- Colors/theme
    use "joshdick/onedark.vim"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = require "plugins.config.treesitter"
    }

    -- LSP
    use "neovim/nvim-lspconfig"
    use "jose-elias-alvarez/null-ls.nvim"
    use {"folke/lsp-trouble.nvim", config = require "plugins.config.trouble"}
    use {"crispgm/nvim-go", config = require "plugins.config.go"}

    -- Buffer and bottom lines
    use {
        "akinsho/nvim-bufferline.lua",
        branch = "main",
        config = require "plugins.config.bufferline"
    }
    use {"nvim-lualine/lualine.nvim", config = require "plugins.config.lualine"}

    -- Git
    use {"lewis6991/gitsigns.nvim", config = require "plugins.config.gitsigns"}
    use {"sindrets/diffview.nvim", config = require "plugins.config.diffview"}

    -- Autocompletion
    use {"hrsh7th/nvim-cmp", config = require "plugins.config.cmp"}
    use "onsails/lspkind-nvim" -- Pictorgrams for suggestions
    -- sources
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-calc"
    use "ray-x/cmp-treesitter"

    -- File Tree
    use {
        "kyazdani42/nvim-web-devicons",
        config = require "plugins.config.devicons"
    }
    use {"kyazdani42/nvim-tree.lua", config = require "plugins.config.nvimtree"}

    -- Telescope
    use "nvim-telescope/telescope-media-files.nvim" -- Shows media file preview in float window
    use "nvim-telescope/telescope-ui-select.nvim"
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    }
    use {
        "nvim-telescope/telescope.nvim",
        config = require "plugins.config.telescope"
    }

    -- Movement
    use {"ggandor/leap.nvim", config = require "plugins.config.leap"}

    -- Stabilized windows
    use {
        "luukvbaal/stabilize.nvim",
        config = require "plugins.config.stabilize"
    }

    -- HTTP client
    use {"NTBBloodbath/rest.nvim", config = require "plugins.config.rest"}

    -- Paranthesis
    use {"windwp/nvim-autopairs", config = require "plugins.config.autopairs"}
    use {"kylechui/nvim-surround", config = require "plugins.config.surround"}

    -- Swap arguments
    use "mizlan/iswap.nvim"

    -- Markdown
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        config = function() vim.g.mkdp_auto_close = 0 end
    }

    -- Indentation
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = require "plugins.config.indent_blankline"
    }
    use "tpope/vim-sleuth" -- Autoconfigure indentation type based on other files

    -- Startup screen
    use {"goolord/alpha-nvim", config = require "plugins.config.alpha"}

    -- Misc
    use "Pocco81/auto-save.nvim"
    use "tpope/vim-commentary" -- Toogle comments with g+c
    use "famiu/bufdelete.nvim" -- Delete buffer without messing up window
    use { -- Everything goes to black hole register by default
        "gbprod/cutlass.nvim",
        config = require "plugins.config.cutlass"
    }

    -- Cache plugins to faster startup
    use "lewis6991/impatient.nvim"
end, {
    display = {
        border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
    }
})
