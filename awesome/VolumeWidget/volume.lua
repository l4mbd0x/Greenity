local wibox = require("wibox")
local awful = require("awful")

volume_widget = wibox.widget.imagebox()

function update_volume(widget)
  local fd = io.popen("amixer sget Master")
  local status = fd:read("*all")
  fd:close()

  local volume = string.match(status, "(%d?%d?%d)%%")
  volume = tonumber(string.format("% 3d", volume))

  status = string.match(status, "%[(o[^%]]*)%]")

  if (volume >= 0 and volume < 60) then volumeLevel=1
    elseif (volume >= 60 and volume < 65) then volumeLevel=2
    elseif (volume >= 65 and volume < 70) then volumeLevel=3
    elseif (volume >= 70 and volume < 75) then volumeLevel=4
    elseif (volume >= 75 and volume < 80) then volumeLevel=5
    elseif (volume >= 80 and volume < 85) then volumeLevel=6
    elseif (volume >= 85 and volume < 90) then volumeLevel=7
    elseif (volume >= 90 and volume < 95) then volumeLevel=8
    elseif (volume >= 95 and volume <= 100) then volumeLevel=9
  end

  widget:set_image("/home/lambd0x/.config/awesome/VolumeWidget/volume-icons/" .. volumeLevel .. ".png")
end

update_volume(volume_widget)

mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
mytimer:start()
