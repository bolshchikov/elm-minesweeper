module Main where

import StartApp.Simple exposing (start)
import Tile

main =
  start
  { model = Tile.init
  , update = Tile.update
  , view = Tile.view
  }
