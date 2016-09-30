module Message exposing (..)

import Component.Error.Message as Error exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)


type Msg
    = Fetch Url
    | Open Url
    | FetchMessages Url
    | UpdateMessages (List Message)
    | FetchComments Message
    | UpdateComments (List Comment)
    | HandleError Error.Msg
