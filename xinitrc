#!/bin/bash

#Set mouse pointers and fonts
xsetroot -cursor_name left_ptr
xset +fp /usr/share/fonts/local
xset fp rehash

#Start some utilities apps
unclutter -grab -idle 10&   #Hide mouse if unused
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
