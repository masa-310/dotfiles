import System.Environment (getEnv)

import XMonad

import XMonad.Layout
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TwoPane

import XMonad.Hooks.ManageDocks(avoidStruts)

import XMonad.Hooks.DynamicLog(dynamicLogWithPP, sjanssenPP, ppOrder)

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
main = do
  modMaskStr <- getEnv "XMONAD_MODMASK"
  let modMask_ = modMaskConv modMaskStr
  xmonad $ (defaultConfig {
    terminal        = terminal_
    , modMask       = mod1Mask
    , layoutHook    = layoutHook_
    , startupHook   = startupHook_
    , logHook       = logHook_
  } `additionalKeysP` [ ("M-d", spawn "dmenu_run") ])
  where
    modMaskConv str
      | str == "mod1Mask" = mod1Mask 
      | str == "mod4Mask" = mod4Mask 
      | otherwise = mod1Mask 
