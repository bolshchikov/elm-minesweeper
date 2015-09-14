module Tile where

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
  { isBomb : Bool
  , isOpened : Bool
  }

type Action = Reveal

init : Model
init =
  { isBomb = False
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
  div [ class "tile" ] [text "Tile"]
