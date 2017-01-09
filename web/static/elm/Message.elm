module Message exposing (..)

import CommentList.Msg as CommentList exposing (Msg)
import Component.Error.Message as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (Msg)
import Component.Infrastructures.Form as Form exposing (..)
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
import Router exposing (Route)
import Router.Msg as Router exposing (Msg)


type Msg
    = -- UI actions
      NoOp
      -- Resource locations
    | InitResource (Result Http.Error AppResource.Model)
      -- Rotue navigation
    | NavigateTo Route
    | RouteUpdate Route
      -- Child Components
    | HandleError Error.Msg
    | Bind (Form.Msg App.Model)
    | Now DateTime.Msg
    | Router Router.Msg
    | MessageList MessageList.Msg
    | Message Message.Msg
    | CommentList CommentList.Msg
