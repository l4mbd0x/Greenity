# Awesome-wm-Funtoo-GreenInfinity
_Funtoo Awesome Wm config file based on the Zenburn Theme (v3.5.9)_

##Dependencies required 
- dbus
- gears                    
- vicious                  
- treesome                 
- beautiful               
- xscreensaver              
- urxvt (rxvt-unicode)     
- scrot (Screenshot for X) 

##Features
- Treesome layout              

_Widgets_ 
- RAM text 
- CPU graph 
- Volume display 
- Uptime toolkit text 
- Default awesome date 
- Download/Upload text 
- Weather display toolkit text 
- Currency USD/BRL toolkit text 

_Keybindings_ 
- Printscreen¹ PrtSc 
- Increase volume F3 
- Decrease volume F2 
- Xscreensaver² lock F12 
_¹screenshots to ~/Screenshots_  
_²controlling locking and its keybinded activation_    

## Install
Clone and copy awesome directory directly to your ~/.config/awesome  

##Note for Funtoo/Gentoo users:  
Emerge
_pixbuf with X jpeg USE flags to solve gears dep_  
_curl with ipv6 ssl openssl flags to solve vicious dep_  
