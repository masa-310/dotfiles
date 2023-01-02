module StartupHook (customStartupHook) where

import Config (MyConfig, getProjects)
import XMonad (X, spawn)
import XMonad.Actions.DynamicProjects (switchProject)
import XMonad.Actions.DynamicWorkspaces (removeWorkspaceByTag)

customStartupHook :: MyConfig -> X ()
customStartupHook myConf = do
  spawn "autorandr default"
  spawn "feh --bg-fill .wallpaper/wallpaper.png"
  spawn "wmname LG3D"
  switchProject $ head (getProjects myConf)
  removeWorkspaceByTag "1"
  removeWorkspaceByTag "2"
