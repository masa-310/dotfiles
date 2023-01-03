module Keymap (applyCustomKeyBindings) where

import Config (MyConfig, getFont, getModMask, getPromptConf)
import Data.Map as Map
import XMonad
import XMonad.Actions.DynamicProjects (shiftToProjectPrompt, switchProjectPrompt)
import XMonad.Actions.Search (google, promptSearchBrowser)
import XMonad.Layout.Maximize (maximizeRestore)
import XMonad.Layout.WorkspaceDir (changeDir)
import XMonad.Prompt (XPConfig (font), greenXPConfig)
import XMonad.Util.EZConfig (additionalKeys, removeKeys)

googleChrome = "/usr/bin/google-chrome-stable"

additionalKeyBindings :: MyConfig -> [((ButtonMask, KeySym), X ())]
additionalKeyBindings myConf =
  let promptConf = getPromptConf myConf
      font = getFont myConf
      modMask = getModMask myConf
   in [ ((modMask, xK_c), changeDir promptConf),
        ((modMask, xK_f), withFocused (sendMessage . maximizeRestore)),
        -- , ((modMask_, xK_h), launchApp def "feh" )
        -- , ((modMask_, xK_e), launchApp promptConf "evince" )
        ((modMask, xK_g), promptSearchBrowser (greenXPConfig {font = font}) googleChrome google),
        ((modMask, xK_d), spawn "dmenu_run"),
        ((modMask, xK_space), switchProjectPrompt promptConf),
        ((modMask, xK_slash), shiftToProjectPrompt promptConf)
      ]

removalKeyBindings :: [(ButtonMask, KeySym)]
removalKeyBindings = []

applyCustomKeyBindings :: MyConfig -> XConfig l -> XConfig l
applyCustomKeyBindings myConfig xconfig =
  (xconfig `removeKeys` removalKeyBindings) `additionalKeys` additionalKeyBindings myConfig
