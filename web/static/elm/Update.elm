module Update exposing (..)

import Commands exposing (..)
import Component.Error.Update as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (update)
import Component.Infrastructures.Form as Form exposing (update)
import Html exposing (..)
import Html.Attributes exposing (..)
import Message exposing (..)
import Models exposing (..)
import Router as Router exposing (Route(..), navigateTo, newUrl)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        ClickAddMessage ->
            model ! [ newUrl Router.NewMessage ]

        InitResource resource ->
            { model | resource = resource } ! [ Commands.fetchMessages resource.messages_url ]

        ListMessages ->
            model ! [ Commands.fetchMessages model.resource.messages_url ]

        RefreshMessages messages ->
            { model | messages = messages } ! []

        Message.NewMessage message ->
            model ! [ Commands.addMessage model.resource.messages_url message ]

        EditMessage message ->
            model ! []

        ListComments message ->
            { model | selectedMessage = Just message } ! [ Commands.fetchComments message.comments_url ]

        RefreshComments comments ->
            { model | comments = comments } ! []

        HandleError msg ->
            let
                ( error, command ) =
                    Error.update msg model.error
            in
                { model | error = error } ! [ Cmd.map HandleError command ]

        Bind msg ->
            let
                ( newModel, command ) =
                    Form.update msg model
            in
                newModel ! [ Cmd.map Bind command ]

        Now msg ->
            let
                ( now, command ) =
                    DateTime.update msg model.now
            in
                { model | now = now } ! [ Cmd.map Now command ]
