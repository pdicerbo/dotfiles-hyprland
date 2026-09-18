---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/configuring/core/binds/

local programs = require("programs")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/configuring/core/binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.browser))
hl.bind(mainMod .. " + x", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.file_manager))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/rofi/applets/volume.sh"))
hl.bind(mainMod .. " + SHIFT + a", hl.dsp.exec_cmd("~/.config/rofi/applets/apps.sh"))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.exec_cmd("~/.config/rofi/powermenu/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float())
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(programs.dmenu))

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("sh ~/.scripts/set-default-wall"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("sh ~/.scripts/wall-changer"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("sh ~/.scripts/aonix-wall-changer"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/"))
hl.bind(mainMod .. " + l", hl.dsp.exec_cmd("hyprlock"))
-- NOTE: the original config bound this to "$SUPER_SHIFT + R", but $SUPER_SHIFT was never
-- defined anywhere (only $mainMod was). In the old parser an undefined variable silently
-- became empty, so that bind actually resolved to plain "R" with no modifier at all.
-- In Lua, referencing an undefined variable is a hard error that would have killed every
-- other bind in this file, so this has been fixed to what was almost certainly intended:
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + k", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + k", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mainMod .. " + j", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + j", hl.dsp.window.alter_zorder({ mode = "top" }))

hl.bind(mainMod .. " + TAB", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + TAB", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.alter_zorder({ mode = "top" }))


-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move silently active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = false }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = false }))

-- Move active window to a workspace with CTRL + SHIFT + [0-9]
hl.bind("CTRL + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = true }))
hl.bind("CTRL + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = true }))
hl.bind("CTRL + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = true }))
hl.bind("CTRL + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = true }))
hl.bind("CTRL + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = true }))
hl.bind("CTRL + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = true }))
hl.bind("CTRL + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = true }))
hl.bind("CTRL + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = true }))
hl.bind("CTRL + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = true }))
hl.bind("CTRL + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = true }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
