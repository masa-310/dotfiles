module Config (MyConfig, mkConfigByHost, getTerminal, getPromptConf, getProjects, getFont, getModMask) where

import Data.Default.Class
import XMonad (KeyMask, mod1Mask, mod4Mask, xK_Tab, xK_grave)
import XMonad.Actions.DynamicProjects (Project (..))
import XMonad.Prompt as Prompt
import XMonad.Prompt.FuzzyMatch (fuzzyMatch)

type HostName = String

data Config = Config
  { terminal :: String,
    font :: String,
    projects :: [Project],
    promptConfig :: XPConfig,
    modMask :: KeyMask
  }

type MyConfig = Config

defaultFont = "xft:DejaVu Sans Mono:alias=true:size=11:hinting=true,xft:Symbola,xft:Noto Color Emoji"

ninjinConfig :: Config
ninjinConfig = def

pandaConfig :: Config
pandaConfig =
  def
    { modMask = mod1Mask
    }

instance Default Config where
  def =
    Config
      { terminal = "lxterminal",
        Config.font = defaultFont,
        projects =
          [ Project
              { projectName = "home",
                projectDirectory = "~",
                projectStartHook = Nothing
              }
          ],
        promptConfig =
          def
            { promptBorderWidth = 1,
              alwaysHighlight = True,
              height = 22,
              historySize = 256,
              Prompt.font = defaultFont,
              -- , bgColor = myBackgroundColor
              -- , fgColor = myContentColor
              -- , bgHLight = myBackgroundColor
              -- , fgHLight = myContentColor
              -- , borderColor = myBackgroundColor
              position = Bottom,
              autoComplete = Just 100,
              showCompletionOnTab = False,
              searchPredicate = fuzzyMatch,
              defaultPrompter = id,
              sorter = const id,
              maxComplRows = Just 7,
              promptKeymap = defaultXPKeymap,
              completionKey = (0, xK_Tab),
              changeModeKey = xK_grave,
              historyFilter = id,
              defaultText = []
            },
        modMask = mod4Mask
      }

mkConfigByHost :: HostName -> Config
mkConfigByHost hostName =
  case hostName of
    "ninjin" -> ninjinConfig
    "panda" -> pandaConfig
    _ -> ninjinConfig

getTerminal :: Config -> String
getTerminal = terminal

getPromptConf :: Config -> XPConfig
getPromptConf = promptConfig

getFont :: Config -> String
getFont = Config.font

getProjects :: Config -> [Project]
getProjects = projects

getModMask :: Config -> KeyMask
getModMask = modMask
