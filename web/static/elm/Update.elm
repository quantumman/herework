module Update exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Message exposing (..)
import Models exposing (..)


update : Msg -> Model -> ( Model, Cmd msg )
update message model =
    case message of
        Fetch resource ->
            model ! []

        Open url ->
            model ! []

        HandleError error ->
            model ! []
