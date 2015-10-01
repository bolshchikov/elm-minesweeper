module Tile (Model, init, makeMine, Action, update, view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
  { isMine : Bool
  , isOpened : Bool
  }

type Action = Reveal

init : Bool -> Model
init isMine =
  { isMine = isMine
  , isOpened = False
  }


makeMine : Model -> Model
makeMine model =
  { model |
    isMine <- True
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
    = toString model.isMine
  in
    if model.isOpened
      then div [ class "tile" ] [ text textValue ]
      else div [ class "tile"
               , onClick address Reveal
               ]
               [ text "Click Me!" ]
