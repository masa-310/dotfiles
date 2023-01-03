import Config (getFont, getModMask, getProjects, getPromptConf, getTerminal, mkConfigByHost)
import Control.Monad
import Data.Maybe (fromMaybe)
import Keymap (applyCustomKeyBindings)
import Layout (customLayoutHook)
import Polybar (polybar)
import StartupHook (customStartupHook)
import System.Environment (lookupEnv)
import XMonad
import XMonad.Actions.DynamicProjects (dynamicProjects)
import XMonad.Hooks.EwmhDesktops (addEwmhWorkspaceSort, ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Hooks.StatusBar (withSB)
import XMonad.Util.Replace (replace)
import XMonad.Util.WorkspaceCompare (filterOutWs)

main :: IO ()
main = do
  myConf <- maybe def mkConfigByHost <$> lookupEnv "XMONAD_HOST"
  let terminal = getTerminal myConf
      projects = getProjects myConf
      promptConf = getPromptConf myConf
      font = getFont myConf
      modMask = getModMask myConf
  replace
  xmonad . withSB polybar . addEwmhWorkspaceSort (pure $ filterOutWs [""]) . ewmhFullscreen . ewmh . docks $
    dynamicProjects projects $
      applyCustomKeyBindings myConf $
        def
          { terminal = terminal,
            modMask = modMask,
            layoutHook = customLayoutHook,
            startupHook = customStartupHook myConf,
            workspaces = []
          }
