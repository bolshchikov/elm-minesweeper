module Main where

import StartApp.Simple exposing (start)
import Html
import Minesweeper

main : Signal Html.Html
main =
  start
  { model = Minesweeper.initGame 5 5 7
  , update = Minesweeper.updateGame
  , view = Minesweeper.renderGame
  }
