---
-- My Xmonad config file
-- Not formatted as the often seen 'Haskell' way.
-- 
-- If you want to use this file, you probably want to change the command
--  piped to myRightBar to something else (conky script or so).
---
import Dzen

import XMonad
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Util.Run
import XMonad.Layout.Named

import XMonad.Util.CustomKeys
import XMonad.Hooks.UrgencyHook
import qualified XMonad.StackSet as W


-- General settings
modMask'  = mod1Mask             -- Xmonad default actions key: Left Alt key
terminal' = "/usr/bin/urxvt"     -- Default terminal (ModMask + ENTER)
term_exec = terminal' ++ " -e "  -- Command to execute terminal applications on

-- Window border settings
myBorderWidth       = 1
normalBorderColor'  = "#3F3E3C"
focusedBorderColor' = "orange" -- "orange" -- "#5F5E5C",

-- Workspaces
workspaces' = ["1:main", "2:web", "3:multimedia", "4:chat", "5", "6", "7", "8", "9:_"]       

--Layouts and layoutHook
gridLayout = named "-|-" $ avoidStruts $ smartBorders $ GridRatio(4/3)

normalLayout = avoidStruts $ tile ||| mtile ||| full
    where
        tall = Tall 1 (3/100) (1/2) -- nmaster delta ratio
        tile  = named "[]="  $ smartBorders tall
        mtile = named "M[]=" $ smartBorders $ Mirror tall
        full  = named "[]"   $ noBorders Full
     
layoutHook' = onWorkspace "9:_" gridLayout $ normalLayout


--Dzen2 bars and logHook
logHook' h = dynamicLogWithPP $ defaultPP { 
    ppCurrent = dzenColor "#ebac54" "#1B1D1E" . pad,
    ppVisible = dzenColor "white" "#1B1D1E" . pad,
    ppHidden = dzenColor "white" "#1B1D1E" . pad,
    ppHiddenNoWindows = dzenColor "#7b7b7b" "#1B1D1E" . pad,
    ppUrgent = dzenColor "red" "#1B1D1E" . pad,
    ppWsSep = "",
    ppSep = " | ",
    ppLayout = dzenColor "#ebac54" "#1B1D1E",
    ppTitle = dzenColor "white" "#1B1D1E" . dzenEscape,
    ppOutput = hPutStrLn h
}

--Dzen Bars
--TODO: Find out how to create a nice multimonitor setup...
--Use the default as a base and override width and coloring
myLeftBar :: DzenConf
myLeftBar = defaultDzen {
    width = Just $ Percent 60, -- span 60%
    Dzen.bgColor = Just "#1B1D1E"
}

--Use the left one as a base, moving it to the right and making it right-aligned.
myRightBar :: DzenConf
myRightBar = myLeftBar {
    xPosition = Just $ Percent 60,  -- start where the other stopped
    width     = Just $ Percent 40,  -- and span the rest
    alignment = Just RightAlign
}


--Custom keys
delkeys XConfig {modMask = modMask'} = []
inskeys conf@(XConfig {modMask = modMask'}) = [
    ((mod4Mask .|. shiftMask, xK_Return   ), spawn "xfce4-terminal"),                  -- spawn XFCE4 terminal
    ((mod4Mask,               xK_4        ), spawn (term_exec ++ "~/programs/chat")),  -- weechat over SSH
    ((mod4Mask,               xK_w        ), spawn (term_exec ++ "wicd-curses")),      -- start wicd-curses
    ((mod4Mask,               xK_a        ), spawn (term_exec ++ "alsamixer")),        -- start alsamixer
    ((mod4Mask,               xK_t        ), spawn (term_exec ++ "htop")),             -- start htop
    
    ((0,                      0x1008ff2a  ), spawn "sudo pm-suspend"),                 -- XF86PowerOff
    ((0,                      0x1008ff02  ), spawn "xbacklight +20"),                  -- XF86MonBrightnessUp
    ((0,                      0x1008ff03  ), spawn "xbacklight -20"),                  -- XF86MonBrightnessDown
    ((0,                      0x1008ff12  ), spawn "amixer -q sset Master toggle"),    -- XF86AudioMute
    ((0,                      0x1008ff11  ), spawn "amixer -q sset Master 6-"),        -- XF86AudioLowerVolume
    ((0,                      0x1008ff13  ), spawn "amixer -q sset Master 6+ unmute"), -- XF86AudioRaiseVolume
    ((0,                      0x1008ff05  ), spawn "~/bin/keyboard.sh incr"),          -- xK_XF86KbdBrightnessUp
    ((0,                      0x1008ff06  ), spawn "~/bin/keyboard.sh decr")           -- xK_XF86KbdBrightnessDown
    ]
    

-- Manage hook: how new windows are placed (workspace and/or floating)
doFullFloat' = doF W.focusDown <+> doFullFloat
myManageHook = manageDocks <+> (composeAll . concat $
    [ [resource     =? r            --> doIgnore           |   r   <- ignores ],
      [className    =? c            --> doShift "1:main"   |   c   <- shifts1 ],
      [className    =? c            --> doShift "2:web"    |   c   <- shifts2 ],
      [className    =? c            --> doShift "3:mmedia" |   c   <- shifts3 ],
      [className    =? c            --> doShift "4:chat"   |   c   <- shifts4 ],
      [className    =? c            --> doShift "5"        |   c   <- shifts5 ],
      [className    =? c            --> doShift "6"        |   c   <- shifts6 ],
      [className    =? c            --> doShift "7"        |   c   <- shifts7 ],
      [className    =? c            --> doShift "8"        |   c   <- shifts8 ],
      [className    =? c            --> doShift "9"        |   c   <- shifts9 ],
      [className    =? c            --> doCenterFloat      |   c   <- floats  ],
      [isFullscreen                 --> doFullFloat'                          ]
    ]) 

    where
        floats  = ["MPlayer","VirtualBox","Xmessage","XFontSel","Downloads","Nm-connection-editor"]
        ignores = ["desktop","desktop_window","notify-osd","stalonetray", "obshutdown"]

        shifts1 = []
        shifts2 = []
        shifts3 = []
        shifts4 = []
        shifts5 = []
        shifts6 = []
        shifts7 = []
        shifts8 = []
        shifts9 = []
    

--Xmonad main loop, all comes together here!
main = do
    dzenTopBar <- spawnDzen myLeftBar
    spawnToDzen "python2 ~/programs/pybar/mybar.py" myRightBar
  
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
        borderWidth = myBorderWidth,
        normalBorderColor  = normalBorderColor',
        focusedBorderColor = focusedBorderColor',

        keys       = customKeys delkeys inskeys,

        layoutHook = layoutHook',
        logHook    = takeTopFocus >> logHook' dzenTopBar,
        workspaces = workspaces',
        manageHook = myManageHook,
        modMask    = modMask',
        terminal   = terminal'
    }
