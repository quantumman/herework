module Message exposing (..)

import Component.Form as Form exposing (..)
import Component.Error.Message as Error exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)


type Msg
    = Fetch Url
    | Open Url
    | InitResource Resource
    | FetchMessages
    | UpdateMessages (List Message)
    | AddMessage Message
    | FetchComments Message
    | UpdateComments (List Comment)
    | HandleError Error.Msg
    | Bind (Form.Msg Model)
