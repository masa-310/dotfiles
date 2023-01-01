import Config (getFont, getModMask, getProjects, getPromptConf, getTerminal, mkConfigByHost)
import Control.Concurrent (threadDelay)
import Control.Monad
import Data.Maybe (fromMaybe)
import Data.Time (getZonedTime)
import Data.Time.Format (defaultTimeLocale, formatTime)
import Polybar (polybar)
import System.Environment (lookupEnv)
import XMonad
import XMonad.Actions.DynamicProjects (Project (..), dynamicProjects, shiftToProjectPrompt, switchProject, switchProjectPrompt)
import XMonad.Actions.DynamicWorkspaces (removeWorkspaceByTag)
import XMonad.Actions.Search
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Hooks.EwmhDesktops (addEwmhWorkspaceSort, ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Hooks.StatusBar (withSB)
import XMonad.Layout (Full)
import XMonad.Layout.Dishes (Dishes (Dishes))
import XMonad.Layout.DragPane
import XMonad.Layout.Drawer (onLeft, simpleDrawer)
import XMonad.Layout.Gaps
import XMonad.Layout.Maximize (maximizeRestore, maximizeWithPadding)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ResizableTile (ResizableTall (ResizableTall))
import XMonad.Layout.Spacing (Border (Border), spacingRaw)
import XMonad.Layout.ThreeColumns (ThreeCol (ThreeColMid))
import XMonad.Layout.ToggleLayouts (toggleLayouts)
import XMonad.Layout.TwoPane (TwoPane (TwoPane))
import XMonad.Layout.WorkspaceDir (changeDir, workspaceDir)
import XMonad.Prompt
import XMonad.Prompt.AppLauncher (launchApp)
import XMonad.Prompt.AppendFile
import XMonad.Prompt.FuzzyMatch (fuzzyMatch)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Replace (replace)
import XMonad.Util.WindowProperties (Property (ClassName, Or))
import XMonad.Util.WorkspaceCompare (filterOutWs)

gap_ = 0

borderWidth_ = 0

-- workspaces_ = map show [1..9]
workspaces_ = []

layoutHook_ =
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

googleChrome = "/usr/bin/google-chrome-stable"

main :: IO ()
main = do
  conf <- maybe def mkConfigByHost <$> lookupEnv "XMONAD_HOST"
  let terminal = getTerminal conf
      projects = getProjects conf
      promptConf = getPromptConf conf
      font = getFont conf
      modMask = getModMask conf
      startupHook_ = do
        spawn "autorandr default"
        spawn "feh --bg-fill .wallpaper/wallpaper.png"
        spawn "wmname LG3D"
        switchProject $ head projects
        removeWorkspaceByTag "1"
        removeWorkspaceByTag "2"
  replace
  xmonad . withSB polybar . addEwmhWorkspaceSort (pure $ filterOutWs [""]) . ewmhFullscreen . ewmh . docks $
    dynamicProjects projects $
      def
        { terminal = terminal,
          modMask = modMask,
          layoutHook = layoutHook_,
          startupHook = startupHook_,
          workspaces = workspaces_
        }
        `additionalKeys` [ ((modMask, xK_c), changeDir promptConf),
                           ((modMask, xK_f), withFocused (sendMessage . maximizeRestore)),
                           -- , ((modMask_, xK_h), launchApp def "feh" )
                           -- , ((modMask_, xK_e), launchApp promptConf "evince" )
                           ( (modMask, xK_n),
                             do
                               date <- io $ fmap (formatTime defaultTimeLocale "[%Y-%m-%d %H:%M] ") getZonedTime
                               appendFilePrompt' promptConf (date ++) "~/NOTES"
                           ),
                           ((modMask, xK_g), promptSearchBrowser (greenXPConfig {font = font}) googleChrome google),
                           ((modMask, xK_d), spawn "dmenu_run"),
                           ((modMask, xK_space), switchProjectPrompt promptConf),
                           ((modMask, xK_slash), shiftToProjectPrompt promptConf)
                         ]
