module Minesweeper (init, update, view) where

import Html exposing (..)
import Html.Attributes exposing (..)

-- MODEL

type alias Game =
  { grid : Grid
  , state : GameState
  }

type alias Grid = List (List Tile)

type alias Tile =
  { isBomb : Bool
  , isMarked : Bool
  , isOpen : Bool
  , value : Int
  , id : Int
}

type GameState = Win | Lose | Play

-- ACTIONS
type Action = Reveal | Mark

update : Action -> Game -> Game
update action game =
  game

-- VIEWS

view : Signal.Address Action -> Game -> Html
view address game =
  let
    cells row = List.map (\cell -> td [ ] [ renderTile address cell ]) row
    rows = List.map (\row -> tr [] ( cells row )) game.grid
  in
    div
      [ id "minsweeper" ]
      [ table
        []
        rows
      ]

renderTile : Signal.Address Action -> Tile -> Html
renderTile address tile =
  div
    []
    [ text "Click Me!" ]

-- INIT

init : Int -> Int -> Int -> Game
init amountOfBombs gridWidth gridHeight =
  { grid = initGrid amountOfBombs gridWidth gridHeight
  , state = Play
  }


initGrid : Int -> Int -> Int -> Grid
initGrid amountOfBombs gridWidth gridHeight =
  initEmptyGrid gridWidth gridHeight


initEmptyGrid : Int -> Int -> Grid
initEmptyGrid width height =
  let
    lowerBound start = start * width + 1
    upperBound start = (start + 1) * width
  in
    List.map (\row -> List.map (\cell -> initTile cell) [lowerBound row..upperBound row]) [0..height - 1]


initTile : Int -> Tile
initTile id =
  { isBomb = False
  , isMarked = False
  , isOpen = False
  , value = 0
  , id = id
  }
