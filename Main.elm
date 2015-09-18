module Main where

import StartApp.Simple exposing (start)
import Html
import Grid

main : Signal Html.Html
main =
  start
  { model = Grid.init 5 5
  , update = Grid.update
  , view = Grid.view
  }
