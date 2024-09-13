return
    { "gbprod/cutlass.nvim", event = "BufEnter", config = function() require("cutlass").setup({ cut_key = "m" }) end }
