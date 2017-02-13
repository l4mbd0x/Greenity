
--[[
                           
 Vertex Awesome WM theme   
 github.com/copycat-killer 
                           
--]]

local gears        = require("gears")
local lain         = require("lain")
local awful        = require("awful")
local wibox        = require("wibox")
local math, string, tonumber, type, os = math, string, tonumber, type, os

local theme                                     = {}
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/vertex/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/awesome/themes/vertex/wall.png"
theme.font                                      = "Roboto Bold 10"
theme.taglist_font                              = "FontAwesome 17"
theme.fg_normal                                 = "#FFFFFF"
theme.fg_focus                                  = "#36E318"--"#6A95EB"
theme.bg_focus                                  = "#303030"
theme.bg_normal                                 = "#242424"
theme.fg_urgent                                 = "#1A3F9B"
theme.bg_urgent                                 = "#6A95E8"
theme.border_width                              = 4
theme.border_normal                             = "#252525"
theme.border_focus                              = "#087C00"
theme.tooltip_border_color                      = theme.fg_focus
theme.tooltip_border_width                      = theme.border_width
theme.menu_height                               = 24
theme.menu_width                                = 140
theme.awesome_icon                              = theme.icon_dir .. "/awesome.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
theme.panelbg                                   = theme.icon_dir .. "/panel.png"
theme.cpu                                       = theme.icon_dir .. "/cpu.png"
theme.ethon                                     = theme.icon_dir .. "/ethernet-connected.png"
theme.ethoff                                    = theme.icon_dir .. "/ethernet-disconnected.png"
theme.volhigh                                   = theme.icon_dir .. "/volume-high.png"
theme.vollow                                    = theme.icon_dir .. "/volume-low.png"
theme.volmed                                    = theme.icon_dir .. "/volume-medium.png"
theme.volmutedblocked                           = theme.icon_dir .. "/volume-muted-blocked.png"
theme.volmuted                                  = theme.icon_dir .. "/volume-muted.png"
theme.voloff                                    = theme.icon_dir .. "/volume-off.png"
theme.net_up                                    = theme.icon_dir .. "/net_up.png"
theme.net_down                                  = theme.icon_dir .. "/net_down.png"
theme.widget_mem                                = theme.icon_dir .. "/mem.png"
theme.widget_temp                               = theme.icon_dir .. "/temp.png"
theme.widget_uptime                             = theme.icon_dir .. "/ac.png"
theme.layout_fairh                              = theme.default_dir.."/layouts/fairhw.png"
theme.layout_fairv                              = theme.default_dir.."/layouts/fairvw.png"
theme.layout_floating                           = theme.default_dir.."/layouts/floatingw.png"
theme.layout_magnifier                          = theme.default_dir.."/layouts/magnifierw.png"
theme.layout_max                                = theme.default_dir.."/layouts/maxw.png"
theme.layout_fullscreen                         = theme.default_dir.."/layouts/fullscreenw.png"
theme.layout_tilebottom                         = theme.default_dir.."/layouts/tilebottomw.png"
theme.layout_tileleft                           = theme.default_dir.."/layouts/tileleftw.png"
theme.layout_tile                               = theme.default_dir.."/layouts/tilew.png"
theme.layout_tiletop                            = theme.default_dir.."/layouts/tiletopw.png"
theme.layout_spiral                             = theme.default_dir.."/layouts/spiralw.png"
theme.layout_dwindle                            = theme.default_dir.."/layouts/dwindlew.png"
theme.layout_cornernw                           = theme.default_dir.."/layouts/cornernww.png"
theme.layout_cornerne                           = theme.default_dir.."/layouts/cornernew.png"
theme.layout_cornersw                           = theme.default_dir.."/layouts/cornersww.png"
theme.layout_cornerse                           = theme.default_dir.."/layouts/cornersew.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 10
theme.titlebar_close_button_normal              = theme.default_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.default_dir.."/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.default_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.default_dir.."/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.default_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.default_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.default_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.default_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.default_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.default_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.default_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.default_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.default_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.default_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.default_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.default_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.default_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.default_dir.."/titlebar/maximized_focus_active.png"

-- http://fontawesome.io/cheatsheet
awful.util.tagnames = {" ", " ", " ", " ", " ", " ", " ", " ", " " }

local markup = lain.util.markup
local space3 = markup.font("Roboto 3", " ")

-- Clock
--os.setlocale(os.getenv("LANG")) -- to localize the clock
local mytextclock = wibox.widget.textclock(markup("#FFFFFF", "%a %d %b, %H:%M"))
mytextclock.font = theme.font
lain.widget.calendar({
    attach_to = { mytextclock },
    notification_preset = {
        fg = "#FFFFFF",
        bg = theme.bg_normal,
        position = "top_right",
        font = "Monospace 10"
    }
})

-- CPU
local cpu_icon = wibox.widget.imagebox(theme.cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(space3 .. markup.font(theme.font, "CPU " .. cpu_now.usage .. "%") .. markup.font("Roboto 5", " "))
    end
})
local cpubg = wibox.container.background(cpu.widget, theme.bg_focus, gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpubg, 0, 0, 5, 5)

-- Net
local netdown_icon = wibox.widget.imagebox(theme.net_down)
local netup_icon = wibox.widget.imagebox(theme.net_up)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font("Roboto 1", " ") .. markup.font(theme.font, math.floor(net_now.received) .. " - " ..
		math.floor(net_now.sent)) .. markup.font("Roboto 2", " "))
    end
})
local netbg = wibox.container.background(net.widget, theme.bg_focus, gears.shape.rectangle)
local networkwidget = wibox.container.margin(netbg, 0, 0, 5, 5)

-- ALSA volume
local volicon = wibox.widget.imagebox()
theme.volume = lain.widget.alsabar({
    togglechannel = "IEC958,3",
    notification_preset = { font = "Monospace 12", fg = theme.fg_normal },
    settings = function()
        local index, perc = "", tonumber(volume_now.level) or 0

        if volume_now.status == "off" then
            index = "volmutedblocked"
        else
            if perc <= 5 then
                index = "volmuted"
            elseif perc <= 25 then
                index = "vollow"
            elseif perc <= 75 then
                index = "volmed"
            else
                index = "volhigh"
            end
        end

        volicon:set_image(theme[index])
    end
})
volicon:buttons(awful.util.table.join (
          awful.button({}, 1, function()
            awful.spawn.with_shell(string.format("%s -e alsamixer", awful.util.terminal))
          end),
          awful.button({}, 2, function()
            awful.spawn(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
            theme.volume.notify()
          end),
          awful.button({}, 3, function()
            awful.spawn(string.format("%s set %s toggle", theme.volume.cmd, theme.volume.togglechannel or theme.volume.channel))
            theme.volume.notify()
          end),
          awful.button({}, 4, function()
            awful.spawn(string.format("%s set %s 1%%+", theme.volume.cmd, theme.volume.channel))
            theme.volume.notify()
          end),
          awful.button({}, 5, function()
            awful.spawn(string.format("%s set %s 1%%-", theme.volume.cmd, theme.volume.channel))
            theme.volume.notify()
          end)
))

-- Weather
theme.weather = lain.widget.weather({
    city_id = 3459712, -- placeholder (London)
    notification_preset = { font = "Monospace 10" },
    settings = function()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(" " .. markup.font(theme.font, units .. "°C") .. " ")
    end
})

-- Mem
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#FFFFFF", mem_now.used .. "M "))
    end
})

-- Launcher
local mylauncher = awful.widget.button({image = theme.awesome_icon})
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

-- Separators
local space = wibox.widget.textbox(" ")
local rspace1 = wibox.widget.textbox()
local rspace0 = wibox.widget.textbox()
local rspace2 = wibox.widget.textbox()
local rspace3 = wibox.widget.textbox()
local tspace1 = wibox.widget.textbox()
tspace1.forced_width = 18
rspace1.forced_width = 16
rspace0.forced_width = 5
rspace2.forced_width = 10
rspace3.forced_width = 25

local lspace1 = wibox.widget.textbox()
local lspace2 = wibox.widget.textbox()
local lspace3 = wibox.widget.textbox()
lspace1.forced_height = 18
lspace2.forced_height = 10
lspace3.forced_height = 16

local barcolor = gears.color({
    type  = "linear",
    from  = { 0, 46 },
    to    = { 46, 46 },
    stops = { {0, theme.bg_focus}, {0.9, "#22AB32"} }
})

local barcolor2 = gears.color({
    type  = "linear",
    from  = { 0, 46 },
    to    = { 46, 46 },
    stops = { {0, "#323232"}, {1, theme.bg_normal} }
})

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal, border = theme.border_width })

    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
        theme.wallpaper = theme.wallpaper(s)
    end
    gears.wallpaper.maximized(theme.wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    s.mypromptbox.bg = "#00000000"

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    s.layoutb = wibox.container.margin(s.mylayoutbox, 8, 11, 3, 3)

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, {
        font = theme.taglist_font,
        shape = gears.shape.rectangle,
        spacing = 10,
        square_unsel = theme.square_unsel,
        bg_focus = barcolor
    }, nil, wibox.layout.fixed.vertical())

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused, awful.util.tasklist_buttons, { bg_focus = "#00000000" })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 25, bg = gears.color.create_png_pattern(theme.panelbg) })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mypromptbox,
            tspace1,
            wibox.container.constraint(s.mytasklist, "exact", s.workarea.width/2.6),
        },
        { -- Middle widgets
            layout = wibox.layout.flex.horizontal,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            netdown_icon,
            networkwidget,
            netup_icon,
            rspace0,
            cpu_icon,
            cpuwidget,
            memicon,
            memory.widget,
            theme.weather.icon,
            theme.weather.widget,
            volicon,
            rspace0,
			mytextclock,
            rspace1,
            wibox.widget.systray(),
        },
    }

    -- Create the vertical wibox
    local dockheight = (40 *  s.workarea.height)/100
    local dockshape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 6)
    end

    s.myleftwibox = wibox({ screen = s, x=0, y=s.workarea.height/2 - dockheight/2, width = 6, height = dockheight, fg = theme.fg_normal, bg = barcolor2, ontop = true, visible = true, type = "dock" })

    -- Add widgets to the vertical wibox
    s.myleftwibox:setup {
        layout = wibox.layout.align.vertical,
        {
            layout = wibox.layout.fixed.vertical,
            lspace1,
            s.mytaglist,
            lspace2,
            s.layoutb,
            wibox.container.margin(mylauncher, 5, 8, 13, 0),
        },
    }

    -- Add toggling functionalities
    s.docktimer = gears.timer{ timeout = 2 }
    s.docktimer:connect_signal("timeout", function()
        s.myleftwibox.width = 6
        s.layoutb.visible = false
        mylauncher.visible = false
        s.docktimer:stop()
    end)
    tag.connect_signal("property::selected", function(t)
        s.myleftwibox.width = 46
        s.layoutb.visible = true
        mylauncher.visible = true
        gears.surface.apply_shape_bounding(s.myleftwibox, dockshape)
        if not s.docktimer.started then
            s.docktimer:start()
        end
    end)

    s.myleftwibox:connect_signal("mouse::leave", function()
        s.myleftwibox.width = 6
        s.layoutb.visible = false
        mylauncher.visible = false
    end)

    s.myleftwibox:connect_signal("mouse::enter", function()
        s.myleftwibox.width = 46
        s.layoutb.visible = true
        mylauncher.visible = true
        gears.surface.apply_shape_bounding(s.myleftwibox, dockshape)
    end)
end

return theme
