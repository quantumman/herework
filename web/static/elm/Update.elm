module Update exposing (..)

import Command exposing (..)
import CommentList.Update as CommentList exposing (..)
import Control.Update as Control exposing (..)
import DateTime.Update as DateTime exposing (..)
import Error.Update as Error exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http as Http exposing (Error)
import List.Extra as List exposing (..)
import Message.Msg as Message exposing (..)
import Message.Update as Message exposing (..)
import MessageList.Msg as MessageList exposing (..)
import MessageList.Update as MessageList exposing (..)
import Model exposing (..)
import Model.Message exposing (Message)
import Msg as App exposing (..)
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

        _ ->
            { model
                | commentList = CommentList.update message model.commentList
                , messageList = MessageList.update message model.messageList
                , message = Message.update message model.message
                , router = Router.update message model.router
                , now = DateTime.update message model.now
                , error = Error.update message model.error
            }
                ! [ CommentList.command message model
                  , MessageList.command message model
                  , Message.command message model
                  , Router.command message model
                  , DateTime.command message model
                  , Error.command message model
                  , Control.command message model
                  ]



-- HELPERS


handleHttpError : Http.Error -> Model -> ( Model, Cmd App.Msg )
handleHttpError error model =
    model ! [ Error.show error ]


findMessage : Int -> List Message -> Maybe Message
findMessage id messages =
    List.find (\x -> x.id == id) messages


findMessageOrDefault : Int -> List Message -> Message -> Message
findMessageOrDefault id messages default =
    findMessage id messages
        |> Maybe.withDefault default
