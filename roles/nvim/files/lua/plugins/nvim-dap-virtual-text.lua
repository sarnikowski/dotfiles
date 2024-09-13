return {
  "theHamsta/nvim-dap-virtual-text",
  config = function()
    function custom_virtual_text(variable, _) return variable.value end
    dap_vt = require("nvim-dap-virtual-text")
    dap_vt.setup({ virt_text_pos = "eol", display_callback = custom_virtual_text })
  end
}
