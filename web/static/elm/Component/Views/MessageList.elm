module Component.Views.MessageList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model m =
    { m
        | messages : List Message
    }


view : Html msg
view =
    div [] []
