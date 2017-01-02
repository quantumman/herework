module Message exposing (..)

import Component.Error.Message as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (Msg)
import Component.Infrastructures.Form as Form exposing (..)
import Component.Views.Messages.Form as MessagesForm exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http as Http exposing (Error)
import Models exposing (..)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message)
import Models.Resource exposing (Resource)
import Models.User exposing (User)
import Router exposing (Route)


type Msg
    = -- UI actions
      NoOp
      -- Resource locations
    | InitResource (Result Http.Error Resource)
      -- Resource Message
    | InitMessage
    | FindMessage Int
    | FindMessageWithComments Int
    | ListMessages
    | RefreshMessages (Result Http.Error (List Message))
    | SaveMessage (Result Http.Error Message)
    | CreateMessage
    | UpdateMessage Message
      -- Resource Comment
    | ListComments Message
    | RefreshComments (Result Http.Error (List Comment))
      -- Rotue navigation
    | NavigateTo Route
    | RouteUpdate Route
      -- Child Components
    | HandleError Error.Msg
    | Bind (Form.Msg Model)
    | Now DateTime.Msg
    | MessagesForm MessagesForm.Msg
