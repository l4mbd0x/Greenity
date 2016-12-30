local wibox = require("wibox")
local awful = require("awful")

weatherWidget = wibox.widget.textbox()

-- DBus (Command are sent to Dbus, which prevents Awesome from freeze)
sleepTimerDbus = timer ({timeout = 1800})
sleepTimerDbus:connect_signal ("timeout", 
  function ()
    awful.util.spawn_with_shell("dbus-send --session --dest=org.naquadah.awesome.awful /com/console/weather com.console.weather.weatherWidget string:$(python ~/.config/awesome/WeatherWidget/weather.py)" )
  end)
sleepTimerDbus:start()

sleepTimerDbus:emit_signal("timeout")

dbus.request_name("session", "com.console.weather")
dbus.add_match("session", "interface='com.console.weather', member='weatherWidget' " )
dbus.connect_signal("com.console.weather", 
  function (...)
    local data = {...}
	local databus1, databus2 = string.match(data[2], "(.*):%s*(.*)")
    weatherWidget:set_text(" Jlle "..databus1.."ºC/"..databus2.."ºC") end)
