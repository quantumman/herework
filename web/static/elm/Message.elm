module Message exposing (..)

import Component.Error.Message as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (Msg)
import Component.Infrastructures.Form as Form exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (..)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message)
import Models.User exposing (User)
import Models.Resource exposing (Resource)


type Msg
    = -- UI actions
      ClickAddMessage
      -- Resource locations
    | InitResource Resource
      -- Resource Message
    | ListMessages
    | RefreshMessages (List Message)
    | NewMessage Message
    | EditMessage Message
      -- Resource Comment
    | ListComments Message
    | RefreshComments (List Comment)
      -- Child Components
    | HandleError Error.Msg
    | Bind (Form.Msg Model)
    | Now DateTime.Msg
