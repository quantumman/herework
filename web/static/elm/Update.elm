module Update exposing (..)

import Commands exposing (..)
import Component.DateTime as DateTime exposing (update)
import Component.Error.Update as Error exposing (..)
import Component.Form as Form exposing (update)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Message exposing (..)
import Models exposing (..)
import Router exposing (Route(..), navigateTo, newUrl)


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
            model ! [ Commands.addMessage model.resource.messages_url message ]

        UpdateMessage message ->
            model ! []

        ClickAddMessage ->
            model ! [ newUrl NewMessage ]

        FetchComments message ->
            { model | selectedMessage = Just message } ! [ Commands.fetchComments message.comments_url ]

        UpdateComments comments ->
            { model | comments = comments } ! []

        HandleError error ->
            let
                ( model', command ) =
                    Error.update error model.error
            in
                { model | error = model' } ! [ Cmd.map HandleError command ]

        Bind msg ->
            let
                ( model', command ) =
                    Form.update msg model
            in
                model' ! [ Cmd.map Bind command ]

        Now msg ->
            let
                ( model', command ) =
                    DateTime.update msg model.dateTime
            in
                { model | dateTime = model' } ! [ Cmd.map Now command ]
