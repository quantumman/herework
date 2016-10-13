module Update exposing (..)

import Component.Form as Form exposing (update)
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

        InitResource resource ->
            { model | resource = resource } ! [ Commands.fetchMessages resource.messages_url ]

        FetchMessages ->
            model ! [ Commands.fetchMessages model.resource.messages_url ]

        UpdateMessages messages ->
            { model | messages = messages } ! []

        AddMessage message ->
            model ! []

        FetchComments message ->
            { model | selectedMessage = message } ! [ Commands.fetchComments message.comments_url ]

        UpdateComments comments ->
            { model | comments = comments } ! []

        HandleError error ->
            model ! []

        Bind msg ->
            let
                ( model', command ) =
                    Form.update msg model
            in
                model' ! [ Cmd.map Bind command ]
