module Minesweeper (initGame, updateGame, renderGame) where

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

updateGame : Action -> Game -> Game
updateGame action game =
  game

-- VIEWS

renderGame : Signal.Address Action -> Game -> Html
renderGame address game =
  let
    cells row = List.map (\cell -> td [ ] [ renderTile address cell ]) row
    rows = List.map (\row -> tr [] ( cells row )) game.grid
  in
    div
      [ id "minesweeper" ]
      [ table
        []
        rows
      ]


renderTile : Signal.Address Action -> Tile -> Html
renderTile address tile =
  div
    []
    [ text <| toString tile.isBomb ]


-- INIT

initGame : Int -> Int -> Int -> Game
initGame amountOfBombs gridWidth gridHeight =
  { grid = initGrid amountOfBombs gridWidth gridHeight
  , state = Play
  }


initGrid : Int -> Int -> Int -> Grid
initGrid amountOfBombs gridWidth gridHeight =
  initEmptyGrid gridWidth gridHeight
    |> fillBombs amountOfBombs


initEmptyGrid : Int -> Int -> Grid
initEmptyGrid width height =
  let
    lowerBound start = start * width + 1
    upperBound start = (start + 1) * width
  in
    [0..height - 1]
      |> List.map (\row -> List.map initTile [lowerBound row..upperBound row]) 


initTile : Int -> Tile
initTile id =
  { isBomb = False
  , isMarked = False
  , isOpen = False
  , value = 0
  , id = id
  }


fillBombs : Int -> Grid -> Grid
fillBombs amountOfBombs grid =
  grid
