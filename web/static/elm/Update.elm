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

        FetchMessages url ->
            model ! [ Commands.get decodeMessages url UpdateMessages ]

        UpdateMessages messages ->
            { model | messages = messages } ! []

        FetchComments message ->
            { model | selectedMessage = message } ! [ Commands.get decodeComments (Resource.Comments message.id) UpdateComments ]

        UpdateComments comments ->
            { model | comments = comments } ! []

        HandleError error ->
            model ! []
