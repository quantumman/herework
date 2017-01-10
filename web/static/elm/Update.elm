module Update exposing (..)

import Commands exposing (..)
import CommentList.Update as CommentList exposing (..)
import Component.Error.Update as Error exposing (..)
import Component.Infrastructures.Form as Form exposing (update)
import DateTime.Update as DateTime exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http as Http exposing (Error)
import List.Extra as List exposing (..)
import Message as App exposing (..)
import Message.Msg as Message exposing (..)
import Message.Update as Message exposing (..)
import MessageList.Msg as MessageList exposing (..)
import MessageList.Update as MessageList exposing (..)
import Models exposing (..)
import Models.Message exposing (Message)
import Router.Command as Router exposing (..)
import Router.Update as Router exposing (..)


update : App.Msg -> Model -> ( Model, Cmd App.Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        InitResource (Ok app) ->
            { model | app = app }
                ! [ MessageList.fetch model ]

        InitResource (Err error) ->
            handleHttpError error model

        NavigateTo route ->
            model ! [ Router.navigateTo route ]

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

        _ ->
            { model
                | commentList = CommentList.update message model.commentList
                , messageList = MessageList.update message model.messageList
                , message = Message.update message model.message
                , router = Router.update message model.router
                , now = DateTime.update message model.now
            }
                ! [ CommentList.command message model
                  , MessageList.command message model
                  , Message.command message model
                  , Router.command message model
                  , DateTime.command message model
                  ]



-- HELPERS


handleHttpError : Http.Error -> Model -> ( Model, Cmd App.Msg )
handleHttpError error model =
    model ! [ Commands.show error ]


findMessage : Int -> List Message -> Maybe Message
findMessage id messages =
    List.find (\x -> x.id == id) messages


findMessageOrDefault : Int -> List Message -> Message -> Message
findMessageOrDefault id messages default =
    findMessage id messages
        |> Maybe.withDefault default
