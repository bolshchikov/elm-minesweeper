module Grid where

import Html exposing (..)
import Tile

type alias Model = List (List (ID, Tile.Model))

type alias ID = String

type Action = Reveal ID Tile.Action


init : Int -> Int -> Model
init x y =
  let
    grid = List.map (\row -> List.map (\column -> toString row ++ toString column) [1..y]) [1..x]
  in
    List.map (\row -> List.map (\cell -> (cell, Tile.init) ) row  ) grid


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
        List.map (\row -> List.map applyTileAction row) model



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
