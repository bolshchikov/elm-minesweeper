module Tile (Model, init, makeMine, Action, update, view) where

import Html exposing (..)
import Utils exposing (onRightClick)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
  { isMine : Bool
  , isOpened : Bool
  , isMarked : Bool
  }


type Action = Reveal | Mark


init : Bool -> Model
init isMine =
  { isMine = isMine
  , isOpened = False
  , isMarked = False
  }


makeMine : Model -> Model
makeMine model =
  { model |
    isMine <- True
  }


reveal : Model -> Model
reveal model =
  { model |
    isOpened <- True
  }


mark : Model -> Model
mark model =
  if model.isMarked
    then { model | isMarked <- False }
    else { model | isMarked <- True }


update : Action -> Model -> Model
update action model =
  case action of
    Reveal ->
      reveal model
    Mark ->
      mark model


view : Signal.Address Action -> Model -> Html
view address model =
  if | model.isOpened ->
        div [ class "tile" ] [ text << toString <| model.isMine ]
     | model.isMarked ->
        div [ class "tile marked"
            , onClick address Reveal
            , onRightClick address Mark
            ] [ text "Marked" ]
     | otherwise  ->
        div [ class "tile"
            , onClick address Reveal
            , onRightClick address Mark
            ]
            [ text "Click Me!" ]
