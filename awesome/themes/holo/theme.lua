
local gears   = require("gears")
local lain    = require("lain")
local vicious = require("vicious")
local awful   = require("awful")
local wibox   = require("wibox")
local string  = string
local os      = { getenv = os.getenv }
local http    = require("socket.http")
local json    = require("json")
local naughty = require("naughty")

local theme                                     = {}
--layouts
theme.treetile_icon                             = os.getenv("HOME") .. "/.config/awesome/treetile/"
theme.lain_icons                                = os.getenv("HOME") .. "/.config/awesome/lain/icons/layout/default/"
theme.layout_termfair    = theme.lain_icons .. "termfair.png"
theme.layout_centerfair  = theme.lain_icons .. "centerfair.png"  -- termfair.center
theme.layout_cascade     = theme.lain_icons .. "cascade.png"
theme.layout_cascadetile = theme.lain_icons .. "cascadetile.png" -- cascade.tile
theme.layout_centerwork  = theme.lain_icons .. "centerwork.png"
theme.layout_centerhwork = theme.lain_icons .. "centerworkh.png" -- centerwork.horizontal
theme.layout_treetile = theme.treetile_icon .. "treetile.png"
--end layouts
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/awesome/themes/holo/wall.png"
theme.font                                      = "Roboto Bold 10"
theme.taglist_font                              = "Roboto Condensed Regular 8"
theme.fg_normal                                 = "#FFFFFF"
theme.fg_focus                                  = "#36E318"
theme.bg_focus                                  = "#303030"
theme.bg_normal                                 = "#242424"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#36E318"
theme.border_width                              = 3
theme.border_normal                             = "#252525"
theme.border_focus                              = "#36E318"
theme.taglist_fg_focus                          = "#FFFFFF"
theme.tasklist_bg_normal                        = "#222222"
theme.tasklist_fg_focus                         = "#36E318"
theme.menu_height                               = 20
theme.menu_width                                = 160
theme.menu_icon_size                            = 32
theme.awesome_icon                              = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                     = theme.icon_dir .. "/funtoo_logo.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
theme.spr_small                                 = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small                            = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right                                 = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right                          = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left                                  = theme.icon_dir .. "/spr_left.png"
theme.bar                                       = theme.icon_dir .. "/bar.png"
theme.bottom_bar                                = theme.icon_dir .. "/bottom_bar.png"
theme.mpdl                                      = theme.icon_dir .. "/mpd.png"
theme.mpd_on                                    = theme.icon_dir .. "/mpd_on.png"
theme.prev                                      = theme.icon_dir .. "/prev.png"
theme.nex                                       = theme.icon_dir .. "/next.png"
theme.currency                                  = theme.icon_dir .. "/curr.png"
theme.stop                                      = theme.icon_dir .. "/stop.png"
theme.pause                                     = theme.icon_dir .. "/pause.png"
theme.play                                      = theme.icon_dir .. "/play.png"
theme.clock                                     = theme.icon_dir .. "/clock.png"
theme.calendar                                  = theme.icon_dir .. "/cal.png"
theme.cpu                                       = theme.icon_dir .. "/cpu.png"
theme.net_up                                    = theme.icon_dir .. "/net_up.png"
theme.net_down                                  = theme.icon_dir .. "/net_down.png"
theme.layout_tile                               = theme.icon_dir .. "/tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "/fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "/fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "/dwindle.png"
theme.layout_max                                = theme.icon_dir .. "/max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "/magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 4
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
awful.util.tagnames = {" ", " ", " ", "  "," ", " ", " ", " ", " " }

theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)

local markup = lain.util.markup
local blue   = "#80CCE6"
local space3 = markup.font("Roboto 3", " ")

-- Clock
local mytextclock = wibox.widget.textclock(markup("#FFFFFF", space3 .. "%H:%M   " .. markup.font("Roboto 4", " ")))
mytextclock.font = theme.font
local clock_icon = wibox.widget.imagebox(theme.clock)
local clockbg = wibox.container.background(mytextclock, theme.bg_focus, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, 0, 3, 5, 5)

-- Calendar
local mytextcalendar = wibox.widget.textclock(markup.fontfg(theme.font, "#FFFFFF", space3 .. "%d %b " .. markup.font("Roboto 5", " ")))
local calendar_icon = wibox.widget.imagebox(theme.calendar)
local calbg = wibox.container.background(mytextcalendar, theme.bg_focus, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(calbg, 0, 0, 5, 5)
lain.widget.calendar({
    attach_to = { mytextclock, mytextcalendar },
    notification_preset = {
        fg = "#FFFFFF",
        bg = theme.bg_normal,
        position = "bottom_right",
        font = "Monospace 10"
    }
})

-- MPD
local mpd_icon = awful.widget.launcher({ image = theme.mpdl, command = theme.musicplr })
local prev_icon = wibox.widget.imagebox(theme.prev)
local next_icon = wibox.widget.imagebox(theme.nex)
local stop_icon = wibox.widget.imagebox(theme.stop)
local pause_icon = wibox.widget.imagebox(theme.pause)
local play_pause_icon = wibox.widget.imagebox(theme.play)
theme.mpd = lain.widget.mpd({
    settings = function ()
        if mpd_now.state == "play" then
            mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
            mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
            widget:set_markup(markup.font("Roboto 4", " ")
                              .. markup.font(theme.taglist_font,
                              " " .. mpd_now.artist
                              .. " - " ..
                              mpd_now.title .. "  ") .. markup.font("Roboto 5", " "))
            play_pause_icon:set_image(theme.pause)
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font("Roboto 4", " ") ..
                              markup.font(theme.taglist_font, " MPD PAUSED  ") ..
                              markup.font("Roboto 5", " "))
            play_pause_icon:set_image(theme.play)
        else
            widget:set_markup("")
            play_pause_icon:set_image(theme.play)
        end
    end
})
local musicbg = wibox.container.background(theme.mpd.widget, theme.bg_focus, gears.shape.rectangle)
local musicwidget = wibox.container.margin(musicbg, 0, 0, 5, 5)

musicwidget:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.spawn(theme.musicplr) end)))
prev_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.spawn.with_shell("mpc prev")
    theme.mpd.update()
end)))
next_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.spawn.with_shell("mpc next")
    theme.mpd.update()
end)))
stop_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    play_pause_icon:set_image(theme.play)
    awful.spawn.with_shell("mpc stop")
    theme.mpd.update()
end)))
play_pause_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.spawn.with_shell("mpc toggle")
    theme.mpd.update()
end)))

-- Weather
theme.weather = lain.widget.weather({
    city_id = 3459712, -- placeholder (London)
    notification_preset = { font = "Monospace 9", position = "bottom_right" },
    settings = function()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(" " .. markup.font(theme.font, units .. "°C") .. " ")
    end
})
--theme.weather.icon
local weawidget_icon = wibox.container.background(theme.weather.icon, theme.bg_focus, gears.shape.rectangle)
local weawidget = wibox.container.background(theme.weather.widget, theme.bg_focus, gears.shape.rectangle)
weatherwidget_icon = wibox.container.margin(weawidget_icon, 0, 0, 5, 5)
weatherwidget = wibox.container.margin(weawidget, 0, 0, 5, 5)

-- Mem
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#FFFFFF", " ".. mem_now.used .. "M (" .. mem_now.perc .. "%)"))
    end
})
local memwidget = wibox.container.background(memory.widget, theme.bg_focus, gears.shape.rectangle)
memorywidget = wibox.container.margin(memwidget, 0, 0, 5, 5)

-- ALSA volume bar
theme.volume = lain.widget.alsabar({
    notification_preset = { font = "Monospace 9"},
    timeout = 1,
    ticks = true,
    width = 80, height = 10, border_width = 0,
    colors = {
        background = "#383838",
        unmute     = theme.fg_focus,
        mute       = "#FF9F9F"
    },
})
theme.volume.bar.paddings = 4
theme.volume.bar.margins = 5
local volumewidget = wibox.container.background(theme.volume.bar, theme.bg_focus, gears.shape.rectangle)
volumewidget = wibox.container.margin(volumewidget, 0, 0, 5, 5)

-- Cpu
local cpu_icon = wibox.widget.imagebox(theme.cpu)
local cput = awful.widget.graph()
cput:set_width(50)
cput:set_background_color(theme.bg_focus)
cput:set_color({ type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#2134B3"}, {0.5, "#178824"}, {1, "#19AF2B" }}})
vicious.register(cput, vicious.widgets.cpu, "$1", 3)
local cpu = wibox.container.margin(cput, 0, 0, 5, 5)

-- Net
local netdown_icon = wibox.widget.imagebox(theme.net_down)
local netup_icon = wibox.widget.imagebox(theme.net_up)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font("Roboto 1", " ") .. markup.font(theme.font, net_now.received .. " - "
                          .. net_now.sent) .. markup.font("Roboto 2", " "))
    end
})
local netbg = wibox.container.background(net.widget, theme.bg_focus, gears.shape.rectangle)
local networkwidget = wibox.container.margin(netbg, 0, 0, 5, 5)

-- Currency
local temp_widget = wibox.widget{
    widget = wibox.widget.textbox,
    font = "Monospace 9",
}

currency_widget = wibox.widget {
    temp_widget,
    layout = wibox.layout.fixed.horizontal,
}

--supposed to update each hour
local currency_timer = timer({ timeout = 3600 })
local resp1
local resp2

currency_timer:connect_signal("timeout", function ()
   awful.spawn.easy_async("date +%H:%M", function(stdout, stderr, reason, exit_code)

   -- Asynchronous call 1
   awful.spawn.easy_async("curl -s 'http://apilayer.net/api/live?access_key=b1cba250b8e5286cefd3f1ffc5e71d42&currencies=BRL&format=1'", function(stdout1, stderr1, reason1, exit_code1)
   if stderr1 == "" then
      resp1 = json.decode(stdout1)
      temp_widget:set_markup(" " .. markup.font(theme.font, "R$ " .. resp1.quotes.USDBRL ))
   end
   end)

   -- Asynchronous call 2
   awful.spawn.easy_async("curl -s 'http://data.fixer.io/api/latest?access_key=7c00a97c6c88aae2a50d57c5baa3c267&symbols=BRL&format=1'", function(stdout2, stderr2, reason2, exit_code2)
   if stderr2 == "" then
      resp2 = json.decode(stdout2)
   end
   end)

   time = stdout
   end)
end)

currency_timer:start()
currency_timer:emit_signal("timeout")

currency_widget:connect_signal("mouse::enter", function()
    naughty.notify{
        font = "Monospace 9",
        text = "USD: " .. resp2.rates.BRL .. " BRL\n" .. "EUR: " .. resp1.quotes.USDBRL .. " BRL\n" ..
               "Updated in: " .. resp2.date .. " " .. time,
        timeout = 5, hover_timeout = 0.1,
        icon = theme.currency,
        icon_size = 100,
        width = 415,
        position = "bottom_right",
    }
end)
local currencybg = wibox.container.background(currency_widget, theme.bg_focus, gears.shape.rectangle)
local currencywidget = wibox.container.margin(currencybg, 0, 0, 5, 5)

-- Launcher
local mylauncher = awful.widget.button({ image = theme.awesome_icon_launcher })
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

-- Separators
local first = wibox.widget.textbox('<span font="Roboto 7"> </span>')
local spr_small = wibox.widget.imagebox(theme.spr_small)
local spr_very_small = wibox.widget.imagebox(theme.spr_very_small)
local spr_right = wibox.widget.imagebox(theme.spr_right)
local spr_bottom_right = wibox.widget.imagebox(theme.spr_bottom_right)
local spr_left = wibox.widget.imagebox(theme.spr_left)
local bar = wibox.widget.imagebox(theme.bar)
local bottom_bar = wibox.widget.imagebox(theme.bottom_bar)

local barcolor  = gears.color({
    type  = "linear",
    from  = { 32, 0 },
    to    = { 32, 32 },
    stops = { {0, theme.bg_focus}, {0.25, "#505050"}, {1, theme.bg_focus} }
})

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
        theme.wallpaper = theme.wallpaper(s)
    end
    gears.wallpaper.maximized(theme.wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, { bg_focus = barcolor })

    mytaglistcont = wibox.container.background(s.mytaglist, theme.bg_focus, gears.shape.rectangle)
    s.mytag = wibox.container.margin(mytaglistcont, 0, 0, 5, 5)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, { bg_focus = theme.bg_focus, shape = gears.shape.rectangle, shape_border_width = 5, shape_border_color = theme.tasklist_bg_normal, align = "center" })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 32 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            s.mytag,
            spr_small,
            s.mylayoutbox,
            spr_small,
            s.mypromptbox,
        },
        nil, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            spr_right,
            musicwidget,
            bar,
            prev_icon,
            next_icon,
            stop_icon,
            play_pause_icon,
            bar,
            mpd_icon,
            bar,
            spr_very_small,
            volumewidget,
            spr_left,
        },
    }

    -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = 32 })
    s.borderwibox = awful.wibar({ position = "bottom", screen = s, height = 1, bg = theme.fg_focus, x = 0, y = 33})

    -- Add widgets to the bottom wibox
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spr_bottom_right,
            netdown_icon,
            networkwidget,
            netup_icon,
            bottom_bar,
            cpu_icon,
            cpu,
            bottom_bar,
            memorywidget,
            bottom_bar,
            currencywidget,
            bottom_bar,
            weatherwidget_icon,
            weatherwidget,
            bottom_bar,
            clock_icon,
            clockwidget,
        },
    }
end

return theme
