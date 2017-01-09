module MessageList.View.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message as App exposing (Msg)
import MessageList.Model as MessageList exposing (..)


view : Model -> Html App.Msg
view model =
    div [] []
