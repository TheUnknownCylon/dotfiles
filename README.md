TheUC dotfiles
--------------

These are my dotfiles.
Installation is quite easy (script from https://github.com/thoughtbot/dotfiles/blob/master/install.sh):

    git clone git://github.com/TheUnknownCylon/dotfiles.git
    cd dotfiles
    ./install.sh


Syten config
============
Currently, the following configs are in this repo:
  
  * Bash
  * urxvt (Terminal)
  * Xmonad (Tiling window manager)

Software
========
If you are running `ArchLinux`, the following commands  might be of interest to you, since they will install all software required to enjoy all this dotfiles functionalities.

    pacman -S git                    # :)
    pacman -S rxvt-unicode           # urxvt
    pacman -S xmonad xmonad-contrib  # Xmonad WM
    pacman -S xcompmgr               # Composition manager

    pacman -S bash-completion        # Better bash autocompletion
    pacman -S pkgfile                # Pkg suggestions on non-installed commando calls
    
    pacman -S udiskie                # Automount disks etc.
    pacman -S unclutter              # If installed, the mouse will be hidden after 10 seconds being unused
    pacman -S nitrogen               # Wallpaper management
