# Awesome-wm-Funtoo-GreenInfinity
_Awesome WM config file based on the Vertex Theme (v4.0)_

## Dependencies required 
| | |
-----
- [x] xset         
- [x] urxvt        
- [x] scrot        
- [x] dmenu        
- [x] gears        
- [x] i3lock       
- [x] Roboto       
- [x] eminent      
- [x] unclutter    
- [x] FontAwesome  

## Features
_Others_
- Binary Tree tiling style layout 

_Widgets_ 
- [x] RAM text                      
- [x] CPU text                      
- [x] Volume display                
- [x] Download/Upload text          
- [x] time/date toolkit text        
- [x] Weather display toolkit text  

_Keybindings_ 
- Printscreen¹ PrtSc 
- Increase volume: F3 
- Decrease volume: F2 
- Screen block: F12
- Applications keybinded: alt + [1, ..., 0]
- Specific application to tags controlled by the above apps keybindings
  - File manager -> Dolphin
  - Image editor -> Gimp, etc.
  - Gaming apps -> Steam, etc.
  - Browser -> Firefox Aurora
  - Document -> Libreoffice, etc.
  - Audio/Video -> Popcorntime, etc.
  - Chat client -> Skypeforlinux, etc.
  - Email client -> Thunderbird/Earlybird
_¹screenshots to ~/Screenshots_  

## Way to use it
Clone and copy awesome directory directly to your ~/.config/awesome  

## Note for Funtoo/Gentoo users  
Emerge
_pixbuf with X jpeg USE flags to solve gears dep_  
_curl with ipv6 ssl openssl flags to solve vicious dep_  
