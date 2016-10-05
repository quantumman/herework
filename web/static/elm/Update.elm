module Update exposing (..)

import Commands exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Message exposing (..)
import Models exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Fetch resource ->
            model ! []

        Open url ->
            model ! []

        FetchMessages url ->
            model ! [ Commands.fetchMessages url ]

        UpdateMessages messages ->
            { model | messages = messages } ! []

        FetchComments message ->
            { model | selectedMessage = message } ! [ Commands.get decodeComments message.comments_url UpdateComments ]

        UpdateComments comments ->
            { model | comments = comments } ! []

        HandleError error ->
            model ! []
