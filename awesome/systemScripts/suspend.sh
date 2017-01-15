#!/bin/bash
dbus-send --system --print-reply --dest="org.freedesktop.DeviceKit.Power" /org/freedesktop/DeviceKit/Power org.freedesktop.DeviceKit.Power.Suspend
