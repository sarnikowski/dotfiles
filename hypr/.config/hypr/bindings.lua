-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Change window close from Super+W to Super+Q
hl.unbind("SUPER + W")
hl.unbind("SUPER + Q")
hl.bind("SUPER + Q", hl.dsp.window.close())

-- Firefox shortcut
o.bind("SUPER + W", "Launch firefox", "exec uwsm app -- firefox")

-- Navigate windows using SUPER + HJKL
hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")

hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" })) -- Left
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" })) -- Down
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" })) -- Up
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" })) -- Right

-- Move windows
hl.unbind("SUPER + SHIFT + UP")
hl.unbind("SUPER + SHIFT + DOWN")
hl.unbind("SUPER + SHIFT + LEFT")
hl.unbind("SUPER + SHIFT + RIGHT")

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" })) -- Swap Left
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" })) -- Swap Down
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" })) -- Swap Up
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" })) -- Swap Right

-- Keybindings
