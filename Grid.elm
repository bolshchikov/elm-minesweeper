module Grid where

import Html exposing (..)
import Tile

type alias Model = List (ID, Tile.Model)

type alias ID = Int

type Action = Reveal ID Tile.Action


init : Int -> Model
init x =
  List.map (\a -> (a, Tile.init)) [1..x]


update : Action -> Model -> Model
update action model =
  case action of
    Reveal id tileAction ->
      let applyTileAction (tileId, tileModel) =
          if id == tileId
            then (tileId, Tile.update tileAction tileModel)
            else (tileId, tileModel)
      in
        List.map applyTileAction model



view : Signal.Address Action -> Model -> Html
view address model =
  div [] (List.map ( tileView address ) model)


tileView : Signal.Address Action -> (ID, Tile.Model) -> Html
tileView address (id, model) =
  Tile.view (Signal.forwardTo address (Reveal id)) model
