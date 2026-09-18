-- See https://wiki.hypr.land/configuring/core/autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("swaync")

    hl.exec_cmd("kitty;", { workspace = "1 silent", float = true, size = { 2200, 1300 }, move = { 846, 751 } })
    hl.exec_cmd("foot unimatrix -ab -c blue -s 93 -l naASCG;", { workspace = "1 silent", float = true, size = { 1000, 600 }, move = { 30, 60 } })
    hl.exec_cmd("kitty cava;", { workspace = "1 silent", float = true, size = { 800, 500 }, move = { 3000, 80 } })
    hl.exec_cmd("foot htop;", { workspace = "1 silent", float = true, size = { 800, 500 }, move = { 30, 1500 } })
    hl.exec_cmd("foot btop;", { workspace = "+1 special:Monitor silent" })
    hl.exec_cmd("foot sudo iftop;", { workspace = "+1 special:Monitor silent" })
    hl.exec_cmd("foot cava;", { workspace = "+2 silent", float = true, size = { 1300, 500 }, move = { 30, 60 } })

    -- dbus session
    hl.exec_cmd("dbus-launch --sh-syntax --exit-with-session")

    -- clipboard history
    hl.exec_cmd("wl-paste --watch cliphist store")
end)
