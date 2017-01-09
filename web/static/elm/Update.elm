module Update exposing (..)

import Commands exposing (..)
import CommentList.Update as CommentList exposing (..)
import Component.Error.Update as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (update)
import Component.Infrastructures.Form as Form exposing (update)
import Component.Views.Messages.Form as MessagesForm exposing (update)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http as Http exposing (Error)
import List.Extra as List exposing (..)
import Message exposing (..)
import Message.Update as Message exposing (..)
import MessageList.Update as MessageList exposing (..)
import Models exposing (..)
import Models.Message exposing (Message)
import Router as Router exposing (Route(..), SubRoute(..), navigateTo, newUrl)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        InitResource (Ok app) ->
            { model | app = app } ! [ Commands.fetchMessages model.app.messages_url FetchMessages ]

        InitResource (Err error) ->
            handleHttpError error model

        NewMessage ->
            let
                entity =
                    Models.Message.initialModel

                newEntity =
                    { entity | creator = model.user }

                messages =
                    model.messages
            in
                { model | messages = { messages | entity = newEntity } } ! []

        FindMessage id ->
            let
                entity =
                    findMessageOrDefault id model.messages.list model.messages.entity

                messages =
                    model.messages
            in
                { model | messages = { messages | entity = entity } } ! []

        FindMessageWithComments id ->
            let
                entity =
                    findMessage id model.messages.list

                messages =
                    model.messages

                listComments =
                    entity
                        |> Maybe.map ListComments
                        |> Maybe.map Commands.run
                        |> Maybe.withDefault Cmd.none

                newEntity =
                    entity
                        |> Maybe.withDefault model.messages.entity
            in
                { model | messages = { messages | entity = newEntity } } ! [ listComments ]

        ListMessages ->
            model ! [ Commands.fetchMessages model.app.messages_url FetchMessages ]

        FetchMessages (Ok messages) ->
            let
                ms =
                    model.messages
            in
                { model | messages = { ms | list = messages } } ! []

        FetchMessages (Err error) ->
            handleHttpError error model

        SaveMessage message ->
            model ! []

        CreateMessage ->
            model ! [ Commands.createMessage model.app.messages_url model.messages.entity SaveMessage ]

        UpdateMessage message ->
            model ! [ Commands.updateMessage message.url message SaveMessage ]

        ListComments message ->
            model ! [ Commands.fetchComments message.comments_url RefreshComments ]

        RefreshComments (Ok comments) ->
            { model | comments = comments } ! []

        RefreshComments (Err error) ->
            handleHttpError error model

        NavigateTo route ->
            model ! [ Router.navigateTo route ]

        RouteUpdate route ->
            model ! [ updateRoute route ]

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

        MessagesForm msg ->
            let
                messages =
                    messagesOfModel.get model

                ( newForm, command ) =
                    MessagesForm.update msg messages.form

                newMessages =
                    { messages | form = newForm }
            in
                (messagesOfModel.set newMessages model) ! [ Cmd.map MessagesForm command ]

        _ ->
            { model
                | commentList = CommentList.update message model.commentList
                , messageList = MessageList.update message model.messageList
                , message = Message.update message model.message
            }
                ! [ CommentList.updateCommand message model.commentList
                  , MessageList.updateCommand message model.messageList
                  , Message.updateCommand message model.message
                  ]


updateRoute : Route -> Cmd Msg
updateRoute route =
    Cmd.batch <|
        case route of
            Messages List ->
                [ Commands.run ListMessages ]

            Messages (Show id) ->
                [ Commands.run (FindMessageWithComments id) ]

            Messages New ->
                [ Commands.run NewMessage ]

            Messages (Edit id) ->
                [ Commands.run (FindMessage id) ]

            Tasks ->
                []

            Activity ->
                []

            NotFound ->
                []



-- HELPERS


handleHttpError : Http.Error -> Model -> ( Model, Cmd Msg )
handleHttpError error model =
    model ! [ Commands.show error ]


findMessage : Int -> List Message -> Maybe Message
findMessage id messages =
    List.find (\x -> x.id == id) messages


findMessageOrDefault : Int -> List Message -> Message -> Message
findMessageOrDefault id messages default =
    findMessage id messages
        |> Maybe.withDefault default
