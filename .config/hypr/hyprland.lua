-----------------
---- PALETTE ----
-----------------

local gruvbox = {
   bg	  = "1d2021",
   bg1	  = "3c3836",
   bg2	  = "504945",
   fg	  = "ebdbb2",
   gray	  = "928374",
   red    = "fb4934",
   green  = "b8bb26",
   yellow = "fabd2f",
   blue   = "83a598",
   purple = "d3869b",
   aqua   = "8ec07c",
   orange = "fe8019",
}

local function rgba(hex, alpha)
   return "rgba(" .. hex .. (alpha or "ff") .. ")"
end

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "2560x1440@165",
    position = "auto",
    scale    = "1",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "wofi --show drun"
local browser	  = "librewolf"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
   hl.exec_cmd("systemctl --user start hyprpolkitagent")
   hl.exec_cmd("easyeffects --gapplication-service")
   hl.exec_cmd("waybar")
   hl.exec_cmd("mako")
   hl.exec_cmd("hyprpaper")
   hl.exec_cmd("hypridle")
   hl.exec_cmd("nwg-look -a")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("XCURSOR_THEME", "Bibata-Modern-Amber")
hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
hl.env("MOZ_ENABLE_WAYLAND","1")
hl.env("GTK_THEME","Gruvbox-Dark")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,

        border_size = 2,

        col = {
	      active_border = {
		 colors = { rgba(gruvbox.yellow, "ee"), rgba(gruvbox.orange, "ee") },
		 angle = 45,
	  },
	  inactive_border = rgba(gruvbox.bg1, "aa"),
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 6,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.92,

        shadow = {
            enabled      = true,
            range        = 18,
            render_power = 3,
            color        = 0xee1d2021,
        },

    blur = {
        enabled   = true,
        size      = 6,
        passes    = 3,

	ignore_opacity    = true,  
	new_optimizations = true, 
	xray              = false, 
	noise             = 0.02,
	contrast          = 1.05,
	brightness        = 0.75,
	vibrancy          = 0.20,
	vibrancy_darkness = 0.30,

	popups             = true,
	popups_ignorealpha = 0.2,
	special            = false,

        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
	preserve_split = true,
    },

    misc = {
       force_default_wallpaper = 0,
       disable_hyprland_logo   = true,
       background_color        = 0x1d2021,       
    }
})

--------------------
---- ANIMATIONS ----
--------------------

-- Curves:
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 }    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 }    } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 }       } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 }    } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 }     } })
hl.curve("overshot",	   { type = "bezier", points =   { { 0.05, 0.9 }, { 0.1, 1.05} } })

-- Springs:
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })
hl.curve("snappy",           { type = "spring", mass = 0.6, stiffness = 320, dampening = 22 })

-- Speed:
hl.animation({ leaf = "global",        enabled = true, speed = 4,    bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 4,    bezier = "easeOutQuint" })

-- Gruvbox Border Gradient:
hl.animation({ leaf = "borderangle",   enabled = true, speed = 40,   bezier = "linear", style = "loop" })
hl.animation({ leaf = "windows",       enabled = true, speed = 3.5,  spring = "snappy" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 3,    spring = "snappy", style = "popin 90%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.5,  bezier = "quick",  style = "popin 92%" })
hl.animation({ leaf = "windowsMove",   enabled = true, speed = 3,    spring = "snappy" })
hl.animation({ leaf = "fade",          enabled = true, speed = 2,    bezier = "quick" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.5,  bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.2,  bezier = "almostLinear" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3,    bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 2.8,  bezier = "overshot",     style = "popin 85%" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.4,  bezier = "quick",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.6,  bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.3,  bezier = "almostLinear" })

-- Slidefade:
hl.animation({ leaf = "workspaces",    enabled = true, speed = 2.5,  bezier = "easeOutQuint", style = "slidefade 15%" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 2.2,  bezier = "easeOutQuint", style = "slidefade 15%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.2,  bezier = "easeOutQuint", style = "slidefade 15%" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "gb",
        follow_mouse = 1,
        sensitivity = 0,
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Apps:
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + F", 	hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", 	hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + D", 	hl.dsp.exec_cmd(menu))

-- Window Management:
hl.bind(mainMod .. " + Q", 	   hl.dsp.window.close())
hl.bind(mainMod .. " + V", 	   hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + P", 	   hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", 	   hl.dsp.layout("togglesplit"))

-- Leave Hyprland:
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

-- Move Focus:
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces:
for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad:
hl.bind(mainMod .. " + S", 	   hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll Through Workspaces:
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Drag To Move / Resize:
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), {mouse = true})
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), {mouse = true})

-- Screenshots:
hl.bind("Print",                hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind("SHIFT + Print",        hl.dsp.exec_cmd([[grim - | wl-copy]]))
hl.bind(mainMod .. " + Print",  hl.dsp.exec_cmd([[mkdir -p "$HOME/Pictures/Screenshots" && grim -g "$(slurp)" - | tee "$HOME/Pictures/Screenshots/shot-$(date +%Y%m%d-%H%M%S).png" | wl-copy]]))

-- Volume:
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -1 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true})

-- Lock And Do Not Disturb:
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("makoctl mode -t do-not-disturb"))

---------------
---- RULES ----
---------------

hl.window_rule({
   name = "suppress-maximize-events",
   match = { class = ".*" },

   suppress_event = "maximize",
})

hl.window_rule ({
   name = "fix-xwayland-drags",
   match = {
      class	= "^$",
      title     = "^$",
      xwayland  = true,
      float     = true,
      fullscreen = false,
      pin	 = false,
  },

  no_focus = true,

})

hl.layer_rule({
    name = "wlogout-blur",
    match = { namespace = "logout_dialog" },
    blur = true,
    blur_popups = true,
})

-- More Blur
hl.layer_rule({ match = { namespace = "waybar" },        blur = true, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "wofi" },          blur = true, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true, ignore_alpha = 0.3 })
