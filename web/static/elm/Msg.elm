module Msg exposing (..)

import CommentList.Msg as CommentList exposing (Msg)
import Control.Msg as Control exposing (Msg)
import DateTime.Msg as DateTime exposing (Msg)
import Error.Msg as Error exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http as Http exposing (Error)
import Message.Msg as Message exposing (Msg)
import MessageList.Msg as MessageList exposing (Msg)
import Model as App exposing (..)
import Model.App as AppResource exposing (Model)
import Model.Comment exposing (Comment)
import Model.Message exposing (Message)
import Model.User exposing (User)
import Router.Msg as Router exposing (Msg)
import App.Msg as App exposing (Msg)


type Msg
    = -- UI actions
      NoOp
      -- Resource locations
    | InitResource (Result Http.Error AppResource.Model)
      -- Child View.
    | App App.Msg
    | Router Router.Msg
    | MessageList MessageList.Msg
    | Message Message.Msg
    | CommentList CommentList.Msg
    | DateTime DateTime.Msg
    | Error Error.Msg
    | Control Control.Msg
