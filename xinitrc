#!/bin/bash

#Set mouse pointers and fonts
xsetroot -cursor_name left_ptr
xset +fp /usr/share/fonts/local
xset fp rehash

#Use the caps lock key as the escape key
xmodmap -e 'clear Lock' 
xmodmap -e 'keycode 0x42 = Escape'

#Swap ALT and Windows key.
xmodmap -e "remove mod4 = Super_L"
xmodmap -e "remove mod1 = Alt_L"
xmodmap -e "add mod4 = Alt_L"
xmodmap -e "add mod1 = Super_L"
xmodmap -e "keycode 133 = Alt_L" 
xmodmap -e "keycode 64 = Super_L"



#Start some utilities apps
unclutter -grab -idle 10&   #Hide mouse if unused
disper -S
nitrogen --restore &        #Restore wallpaper
xcompmgr &                  #Composition manager, transparent windows
udiskie &                   #Automount media devices
eject -x 4 &                #Reduce disk spinning noise


#Start the Desktop environment
DEFAULT_SESSION=xmonad
case $1 in
  xfce4)
    exec startxfce4
    ;;
  gnome)
    exec gnome-session
    ;;
  kde)
    exec startkde
    ;;
  xmonad)
    exec xmonad
    ;;
  *)
    exec $DEFAULT_SESSION
    ;;
esac
