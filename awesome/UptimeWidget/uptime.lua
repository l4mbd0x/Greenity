local wibox = require("wibox")
local awful = require("awful")
local vicious = require("../vicious")
uptimeWidget = wibox.widget.imagebox()

uptimeWidget2 = awful.tooltip({ objects = {uptimeWidget}, })
vicious.register(uptimeWidget, vicious.widgets.uptime, function (widget, args)
uptimeWidget2:set_text("24/7 for "..args[1]..' days '..args[2]..'hrs '..args[3]..'mins') end)

function image3(widget)
  widget:set_image("/home/lambd0x/.config/awesome/UptimeWidget/img1.png")
end

image3(uptimeWidget)
mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () image3(uptimeWidget) end)
mytimer:start()
