import XMonad
-- additionalKeysP
import XMonad.Util.EZConfig (additionalKeysP)
-- layout
import XMonad.Layout
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TwoPane

main :: IO()

terminal_ = "urxvt"
modMask_ = mod1Mask
layoutHook_ =
  (ThreeColMid 1 (3/100) (1/2))
  ||| (ResizableTall 1 (3/100) (3/5) [])
  ||| (TwoPane (3/100) (3/5))
  ||| Full
startupHook_ = do
  spawn "feh --bg-scale ~/.wallpaper/wallpaper1.png"

main =
  xmonad $ def {
    terminal        = terminal_
    , modMask       = modMask_
    , layoutHook    = layoutHook_
    , startupHook   = startupHook_
  }
  `additionalKeysP`
  [
    ("M-d", spawn "dmenu_run")
  --  , ("M-p", shellPrompt def)
  ]
