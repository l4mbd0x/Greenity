-- {{{ Required libraries
local awesome, client, screen, tag = awesome, client, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
--treetile tiling style
local treetile      = require("treetile")
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

run_once({ "urxvtd", "unclutter -root" })
-- }}}

-- {{{ Variable definitions
local modkey         = "Mod4"
local altkey         = "Mod1"
local leftshiftkey   = "Shift"
local leftcontrolkey = "Control"
local editor         = os.getenv("EDITOR") or "vim" or "vi"
local browser        = "firefox"
local terminal       = "urxvtc"
local gaming_1       = "STEAM_RUNTIME=1 steam"
local gamingChat       = "discord"
--local gaming_2       = "playonlinux"
local screenshot     = "scrot -e 'mv $f ~/Screenshots/ 2>/dev/null'"
local pdf_viewer2    = "okular"
local pdf_viewer     = "evince"
--local stream_plat    = "urxvtc -e .Stremio/Stremio-runtime"
local latex_editor   = "kile"
local image_editor   = "gimp"
--local file_manager   = "KDE_SESSION_VERSION=5; export KDE_SESSION_VERSION; KDE_FULL_SESSION=true; export KDE_FULL_SESSION; dolphin"
local email_client   = "thunderbird"
local chosen_theme   = "holo"
local vector_editor  = "inkscape"
local office_editor  = "libreoffice"
local torrent_client = "transmission-gtk"
local mindmap_editor = "xmind"
local pass_manager   = "urxvtc -e Encryptr"
local online_editor  = "turtl"
local uml_editor     = "argouml"
local chat_client    = "skypeforlinux"
--local virt_manager   = "virtualbox"
local acad_ref_man   = "zotero"
--local android_dev    = "android-studio"
local irc_client     = "urxvtc -e irssi"
local remote_client  = "anydesk"
local dvd_suite      = "k3b"
awful.util.terminal  = terminal

awful.layout.layouts = {
    --awful.layout.suit.floating,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
    --lain.layout.centerwork,
    treetile,
}
awful.util.taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )
awful.util.tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function()
                         local instance = nil

                         return function ()
                             if instance and instance.wibox.visible then
                                 instance:hide()
                                 instance = nil
                             else
                                 instance = awful.menu.clients({ theme = { width = 250 } })
                             end
                        end
                     end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
-- }}}

-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}

local myosmenu = {
    { "shutdown", function() awful.spawn.with_shell("dbus-send --system --print-reply --dest='org.freedesktop.ConsoleKit' /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop") end },
    {   "reboot", function() awful.spawn.with_shell("dbus-send --system --print-reply --dest='org.freedesktop.ConsoleKit' /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart") end },
    { "suspend" , function() awful.spawn.with_shell("dbus-send --system --print-reply --dest='org.freedesktop.ConsoleKit' /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Suspend  boolean:true") end }
}

awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        { "Energy", myosmenu },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})
--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

    -- Treetile vertical/horizontal split control
    awful.key({ modkey, leftshiftkey }, "h", treetile.vertical),
    awful.key({ modkey, leftshiftkey }, "v", treetile.horizontal),


    -- Scrot screenshot
     awful.key({ }, "Print", function () awful.util.spawn_with_shell(screenshot) end),

    -- Hotkeys
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    -- Tag browsing
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ altkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end),   -- move to next tag
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end), -- move to previous tag
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ altkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Dropdown application
    awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end),

    -- Widgets popups
    awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end),
    awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end),
    awful.key({ altkey, }, "m", function () if beautiful.currency_widget then beautiful.currency_widget.show(7) end end),

    -- Xscreensaver lock screen
    --awful.key({}, "F11", function () awful.util.spawn("xscreensaver-command -lock") end),

    -- I3lock lock screen
    awful.key({ }, "F12", function () awful.util.spawn_with_shell("sh ~/.config/awesome/lock/i3lock.sh") end),

    -- ALSA volume control
    -- Increase
    awful.key({ }, "F3", function () awful.util.spawn("amixer set Master 5%+") end),
    -- Decrease
    awful.key({ }, "F2", function () awful.util.spawn("amixer set Master 5%-") end),

    -- User programs
    -- Web
    awful.key({ modkey, altkey }, "b", function () awful.spawn(browser) end),
    awful.key({ modkey, altkey }, "e", function () awful.spawn(email_client) end),
    awful.key({ modkey, altkey }, "t", function () awful.spawn(torrent_client) end),
    -- File management
    awful.key({ modkey, altkey }, "f", function () awful.util.spawn_with_shell(file_manager) end),
    -- Image editing
    awful.key({ modkey, altkey }, "i", function () awful.spawn(image_editor) end),
    awful.key({ modkey, altkey }, "v", function () awful.spawn(vector_editor) end),
    -- File editing
    awful.key({ modkey, altkey }, "o", function () awful.spawn(office_editor) end),
    awful.key({ modkey, altkey }, "n", function () awful.spawn(online_editor) end),
    awful.key({ modkey, altkey }, "p", function () awful.spawn(pdf_viewer) end),
    awful.key({ modkey, altkey, leftcontrolkey }, "p", function () awful.spawn(pdf_viewer2) end),
    awful.key({ modkey, altkey }, "l", function () awful.spawn(latex_editor) end),
    awful.key({ modkey, altkey }, "m", function () awful.spawn(mindmap_editor) end),
    awful.key({ modkey, altkey }, "u", function () awful.spawn(uml_editor) end),
    -- DVD/CD/Bry Ray suite
    awful.key({ modkey, altkey }, "d", function () awful.spawn(dvd_suite) end),
    -- Social
    awful.key({ modkey, altkey }, "c", function () awful.spawn(chat_client) end),
    -- Gaming
    awful.key({ modkey, altkey }, "g", function () awful.util.spawn_with_shell(gaming_1) end),
    --awful.key({ modkey, altkey, leftshiftkey }, "g", function () awful.util.spawn_with_shell(gaming_2) end),
    -- Gaming
    awful.key({ modkey, altkey, leftshiftkey }, "g", function () awful.util.spawn_with_shell(gamingChat) end),
    -- Streaming platform
    awful.key({ modkey, altkey }, "s", function () awful.spawn(stream_plat) end),
    -- Password manager
    awful.key({ modkey, altkey, leftshiftkey }, "p", function () awful.spawn(pass_manager) end),
    -- Virtualization
    awful.key({ modkey, altkey, leftshiftkey }, "v", function () awful.spawn(virt_manager) end),
    -- Academic References
    awful.key({ modkey, altkey}, "a", function () awful.spawn(acad_ref_man) end),
    -- Android development
    awful.key({ modkey, altkey, leftshiftkey }, "a", function () awful.spawn(android_dev) end),
    -- IRC Client
    awful.key({ modkey, altkey, leftshiftkey }, "c", function () awful.spawn(irc_client) end),
    -- Remote Access
    awful.key({ modkey, altkey}, "r", function () awful.spawn(remote_client) end),

    -- Prompt
    awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
--]]
)

clientkeys = awful.util.table.join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client                         ),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = true } },

    -- Set Firefox web browser to always map on the first tag on screen 1.
    { rule = { class = "Firefox" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[1] } },

    -- Set Dolphin file manager to always map on the fifth tag on screen 1.
    { rule = { class = "dolphin" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[5] } },

    -- Set Thunderbird email client to always map on the sixth tag on screen 1.
    { rule = { class = "Thunderbird" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[6] } },

    -- Set Gimp to always map on the fourth tag on screen 1.
    { rule = { class = "Gimp" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[4] } },

    -- Set Inkscape to always map on the fourth tag on screen 1.
    { rule = { class = "Inkscape" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[4] } },

    -- Set Libreoffice to always map on the third tag on screen 1.
    { rule = { class = "libreoffice" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[3] } },

    -- Set Turtl to always map on the third tag on screen 1.
    { rule = { class = "Turtl" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[3] } },

    -- Set Okular PDF file viewer to always map on the fourth tag on screen 1.
    { rule = { class = "okular" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[5] } },

    -- Set Evince PDF file viewer to always map on the fourth tag on screen 1.
    { rule = { name = "Recent Documents" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[5] } },

    -- Set Kile to always map on the third tag on screen 1.
    { rule = { name = "Kile" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[3] } },

    -- Set Steam to always map on the ninth tag on screen 1.
    { rule = { class = "Steam" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[9] } },

    -- Set Discord to always map on the ninth tag on screen 1.
    { rule = { name = "Discord" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[9] } },

     -- Set Skype for Linux to always map on the seventh tag on screen 1.
    { rule = { name = "Skype" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[7] } },

    -- Set Telegram to always map on the seventh tag on screen 1.
    { rule = { class = "Telegram" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[7] } },

    -- Set rxvt-unicode terminal emulator to always map on the second tag on screen 1.
    { rule = { class = "URxvt" },
      properties = { screen = 1, tag = screen[1].tags[2] } },

    -- Set Transmission torrent client to always map on the eighth tag on screen 1.
    { rule = { name = "Transmission" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[8] } },

    -- Set Xmind to always map on the fourth tag on screen 1.
    { rule = { class = "XMind" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[4] } },

-- Set Argouml to always map on the fourth tag on screen 1.
    { rule = { name = "ArgoUML" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[4] } },

    -- Set Encryptr to always map to the eighth tag of screen 1 and switch to this very tag.
    { rule = { name = "Encryptr" },
      properties = { screen = 1, switchtotag = true, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[8] } },

    -- Set Stremio to always map to the eighth tag of screen 1.
    { rule = { name = "Stremio" },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[8] } },

    -- Set feh to always map to the third tag of screen 1 and switch to this very tag
    { rule = { name = "feh" },
      properties = { screen = 1, switchtotag = true, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[4] } },

    -- Set mpv to always map to the eighth tag of screen 1 and switch to this very tag
    { rule = { name = "mpv" },
      properties = { screen = 1, switchtotag = true, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[8] } },

    -- Set Zotero to always map to the eighth tag of screen 1
    { rule = { name = "Zotero" },
      properties = { screen = 1, switchtotag = false, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[8] } },

    -- Set Android Studio to always map to third tag of screen 1
    { rule = { class = "jetbrains-studio" },
      properties = { screen = 1, switchtotag = false, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[3] } },

    -- Set irssi to always map to the seventh tag of screen 1
    { rule = { name = "irssi" },
      properties = { screen = 1, switchtotag = false, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[7] } },

    -- Set Anydesk to always map to the eighth tag of screen 1
    { rule = { name = "AnyDesk" },
      properties = { screen = 1, switchtotag = false, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[8] } },

    -- Set k3b kde dvd/cd suite to always map to the fifth tag of screen 1
    { rule = { name = "K3b" },
      properties = { screen = 1, switchtotag = false, maximized_vertical = true, maximized_horizontal = true, tag = screen[1].tags[5] } },



}
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 16}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized then -- no borders if only 1 client visible
            c.border_width = 0
        elseif #awful.screen.focused().clients > 1 then
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--Autorun xscreensaver daemon
awful.spawn.with_shell("xscreensaver -no-splash")
-- }}}
