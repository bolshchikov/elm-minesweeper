module Main where

import StartApp.Simple exposing (start)
import Html
import Grid

main : Signal Html.Html
main =
  start
  { model = Grid.init 3 5 7
  , update = Grid.update
  , view = Grid.view
  }
