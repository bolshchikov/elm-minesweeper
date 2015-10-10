module Main where

import StartApp.Simple exposing (start)
import Html
import Minesweeper

main : Signal Html.Html
main =
  start
  { model = Minesweeper.init 5 5 7
  , update = Minesweeper.update
  , view = Minesweeper.view
  }
