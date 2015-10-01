module Grid (init, update, view) where

import Random
import Html exposing (..)
import Tile

type alias Model = List (List (ID, Tile.Model))

type alias ID = Int

type Action = Reveal ID Tile.Action


makeGrid : Int -> Int -> Model
makeGrid width height =
  let
    lowerBound start = start * width + 1
    upperBound start = (start + 1) * width
  in
    List.map (\row -> List.map (\cell -> (cell, Tile.init False)) [lowerBound row..upperBound row]) [0..height - 1]


fillMines : Int -> Int -> Model -> Model
fillMines minesAmount range grid =
  let
    seed = Random.initialSeed Random.maxInt
    listGenerator = Random.list minesAmount (Random.int 1 range)
    locations = fst <| Random.generate listGenerator seed
    markAsMine cell =
      if List.member (fst cell) locations
        then (fst cell, Tile.makeMine <| snd <| cell)
        else cell
  in
    List.map (\row -> List.map markAsMine row) grid


init : Int -> Int -> Int -> Model
init minesAmount width height =
  let
    emptyGrid = makeGrid width height
  in
    fillMines minesAmount (width * height) emptyGrid


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
