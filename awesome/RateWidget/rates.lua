local wibox = require("wibox")
local awful = require("awful")

rateWidget = wibox.widget.imagebox()

-- DBus (Command are sent to Dbus, which prevents Awesome from freeze)
sleepTimerDbus = timer ({timeout = 1800})--each 1hr
sleepTimerDbus:connect_signal ("timeout", 
  function ()
    awful.util.spawn_with_shell("dbus-send --session --dest=org.naquadah.awesome.awful /com/console/rate com.console.rate.rateWidget string:$(python ~/.config/awesome/RateWidget/rates.py)" )
  end)
sleepTimerDbus:start()

sleepTimerDbus:emit_signal("timeout")

dbus.request_name("session", "com.console.rate")
dbus.add_match("session", "interface='com.console.rate', member='rateWidget' " )
dbus.connect_signal("com.console.rate", 
  function (...)
    local data = {...}
    local value = data[2]
	local value = data[2]
	rateWidget2 = awful.tooltip({ objects = {rateWidget}, })
	rateWidget2:set_text("1 USD values "..value.." BRL") end)

function image2(widget)
  widget:set_image("/home/lambd0x/.config/awesome/RateWidget/img1.png")
end

image2(rateWidget)
mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () image2(rateWidget) end)
mytimer:start()

