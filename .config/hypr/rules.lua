-- See https://wiki.hypr.land/configuring/core/rules/window-rules/ for more
-- See https://wiki.hypr.land/configuring/core/rules/workspace-rules/ for workspace rules

-- Example windowrule
-- hl.window_rule({ match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Ignore shadow in rofi
hl.window_rule({ match = { class = "^rofi$" }, no_shadow = true })

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_initial_focus = true,
})

-- Force floating for all applications by default
hl.window_rule({ match = { class = ".*" }, float = true })

-- Force tiling for Monitor special workspace
hl.window_rule({ match = { workspace = "name:Monitor" }, tile = true })
-- hl.window_rule({ match = { class = "foot" }, tile = true })


hl.window_rule({ match = { class = "^(pavucontrol)$" }, opacity = "0.3 override" })
-- NOTE: layer_rule's documented `match` props only support `namespace`, not `class` (that's a
-- window-rule prop). This line is carried over verbatim from the old config, but it most likely
-- never matched anything even before the migration, since pavucontrol is a regular window, not
-- a layer-shell surface. Left as-is for fidelity; consider removing or replacing with a
-- windowrule `no_blur = false`-style effect if you actually wanted pavucontrol blurred.
hl.layer_rule({ match = { class = "^(pavucontrol)$" }, blur = true })

-- Blur for SwayNC
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true })

hl.layer_rule({ match = { namespace = "swaync-control-center" }, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, ignore_alpha = 0.3 })

hl.layer_rule({ match = { namespace = "rofi" }, animation = "popin 90%" })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, animation = "popin 90%" })

-- blur for rofi
hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
