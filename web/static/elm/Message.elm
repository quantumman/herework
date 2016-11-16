module Message exposing (..)

import Component.Error.Message as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (Msg)
import Component.Infrastructures.Form as Form exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message)
import Models.User exposing (User)
import Models.Resource exposing (Resource)


type Msg
    = Fetch Url
    | Open Url
    | InitResource Resource
    | FetchMessages
    | UpdateMessages (List Message)
    | AddMessage Message
    | UpdateMessage Message
    | ClickAddMessage
    | FetchComments Message
    | UpdateComments (List Comment)
    | HandleError Error.Msg
    | Bind (Form.Msg Model)
    | Now DateTime.Msg
