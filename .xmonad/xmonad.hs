import System.Environment (getEnv)

import XMonad

import XMonad.Layout
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TwoPane

import XMonad.Layout.ManageDocks(avoidStruts)

import Xmonad.Hooks.DynamicLog(DynamicLogPP, sjassenPP)

import XMonad.Util.EZConfig (additionalKeysP)



terminal_ = "urxvt"

layoutHook_ =
  avoidStruts
  $ (ThreeColMid 1 (3/100) (1/2))
  ||| (ResizableTall 1 (3/100) (3/5) [])
  ||| (TwoPane (3/100) (3/5))
  ||| Full
startupHook_ = do
  spawn "feh --bg-scale ~/.wallpaper/wallpaper1.png"

statusBar = "xmobar"
logHook_ = dynamicLogWithPP $ sjanssenPP { ppOrder = reverse }

main :: IO()
main =
  modMaskStr <- getEnv "XMONAD_MODMASK"
  let modMask_ = case modMaskStr of
    "mod1Mask" -> mod1mask
    "mod4Mask" -> mod4mask
    _ -> mod1mask
  xmonad $ defaultConfig {
    terminal        = terminal_
    , modMask       = modMask_
    , layoutHook    = layoutHook_
    , startupHook   = startupHook_
    , logHook       = logHook_
  }
  `additionalKeysP`
  [
    ("M-d", spawn "dmenu_run")
  ]
