module Message.View.Message exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message as App exposing (Msg)
import Message.Model as Messagc exposing (..)


view : Model -> Html App.Msg
view model =
    div [] []
