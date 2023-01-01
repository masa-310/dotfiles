module Polybar (polybar) where

import StatusBarPP (statusBarPP)
import XMonad.Hooks.StatusBar (statusBarProp)

polybar = statusBarProp "polybar" (pure statusBarPP)
