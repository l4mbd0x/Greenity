local wibox = require("wibox")
local awful = require("awful")

weatherWidget = wibox.widget.imagebox()

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
	local tempC, feelsC = string.match(data[2], "(.*);s*(.*)")
	weatherWidget2 = awful.tooltip({ objects = {weatherWidget}, })
	weatherWidget2:set_text("Temperature: "..tempC.."ºC\nFeels like: "..feelsC.."ºC\nJoinville, Santa Catarina - Brazil") end)

function image(widget)
  widget:set_image("/home/lambd0x/.config/awesome/WeatherWidget/img1.png")
end

image(weatherWidget)
mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () image(weatherWidget) end)
mytimer:start()


