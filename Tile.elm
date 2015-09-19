module Tile(Model, init, Action, update, view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
  { isBomb : Bool
  , isOpened : Bool
  }

type Action = Reveal

init : Bool -> Model
init isBomb =
  { isBomb = isBomb
  , isOpened = False
  }

update : Action -> Model -> Model
update action model =
  case action of
    Reveal ->
      { model |
        isOpened <- True
      }

view : Signal.Address Action -> Model -> Html
view address model =
  let textValue
    = toString model.isBomb
  in
    if model.isOpened
      then div [ class "tile" ] [ text textValue ]
      else div [ class "tile"
               , onClick address Reveal
               ]
               [ text "Click Me!" ]
