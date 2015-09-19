module Grid where

import Html exposing (..)
import Tile

type alias Model = List (List (ID, Tile.Model))

type alias ID = Int

type Action = Reveal ID Tile.Action


init : Int -> Int -> Int -> Model
init bombs width height =
  List.map (\row -> List.map (\cell -> (cell, Tile.init False)) [row * width + 1..(row + 1) * width]) [0..height - 1]


update : Action -> Model -> Model
update action model =
  case action of
    Reveal id tileAction ->
      let
        applyTileAction (tileId, tileModel) =
          if id == tileId
            then (tileId, Tile.update tileAction tileModel)
            else (tileId, tileModel)
      in
        List.map (\col -> List.map applyTileAction col) model



view : Signal.Address Action -> Model -> Html
view address model =
  let
    cells row = List.map (\cell -> td [] [ text (toString (fst cell)), tileView address cell ]) row
    rows = List.map (\row -> tr [] ( cells row )) model
  in
    table [] (rows)


tileView : Signal.Address Action -> (ID, Tile.Model) -> Html
tileView address (id, model) =
  Tile.view (Signal.forwardTo address (Reveal id)) model
