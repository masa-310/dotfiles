module Layout (customLayoutHook) where

import XMonad (Full (Full), (|||))
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Layout.Drawer (Property (ClassName, Or), simpleDrawer)
import XMonad.Layout.Maximize (maximizeWithPadding)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ResizableTile (ResizableTall (ResizableTall))
import XMonad.Layout.Spacing (Border (Border), spacingRaw)
import XMonad.Layout.ThreeColumns (ThreeCol (ThreeColMid))
import XMonad.Layout.ToggleLayouts (toggleLayouts)
import XMonad.Layout.TwoPane (TwoPane (TwoPane))
import XMonad.Layout.WorkspaceDir (workspaceDir)

customLayoutHook =
  workspaceDir "~" $
    avoidStruts $
      toggleLayouts (noBorders Full) $
        spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True $
          maximizeWithPadding
            10
            ( ResizableTall 1 (3 / 100) (3 / 5) []
                -- can use something useful?
                --  $ drawer `onLeft` (ResizableTall 1 (3/100) (3/5) [])
                --  ||| Dishes 2 (1/6)
                --  ||| dragPane Horizontal 0.1 0.5
                ||| ThreeColMid 1 (3 / 100) (1 / 2)
                ||| TwoPane (3 / 100) (3 / 5)
                ||| Full
            )
  where
    drawer = simpleDrawer 0.01 0.3 (ClassName "Rhythmbox" `Or` ClassName "Xchat")
