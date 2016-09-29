module Update exposing (..)

import Commands exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Message exposing (..)
import Models exposing (..)
import Resource as Resource exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Fetch resource ->
            model ! []

        Open url ->
            model ! []

        FetchMessages ->
            model ! [ Commands.get decodeMessages Resource.Messages UpdateMessages ]

        UpdateMessages messages ->
            { model | messages = messages } ! []

        HandleError error ->
            model ! []
