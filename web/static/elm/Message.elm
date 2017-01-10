module Message exposing (..)

import CommentList.Msg as CommentList exposing (Msg)
import DateTime.Msg as DateTime exposing (Msg)
import Error.Msg as Error exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http as Http exposing (Error)
import Message.Msg as Message exposing (Msg)
import MessageList.Msg as MessageList exposing (Msg)
import Models as App exposing (..)
import Models.App as AppResource exposing (Model)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message)
import Models.User exposing (User)
import Router.Msg as Router exposing (Msg)


type Msg
    = -- UI actions
      NoOp
      -- Resource locations
    | InitResource (Result Http.Error AppResource.Model)
      -- Rotue navigation
    | NavigateTo Router.Msg
      -- Child Components
    | Router Router.Msg
    | MessageList MessageList.Msg
    | Message Message.Msg
    | CommentList CommentList.Msg
    | DateTime DateTime.Msg
    | Error Error.Msg
