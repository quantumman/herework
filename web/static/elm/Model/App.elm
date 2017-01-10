module Model.App exposing (..)

import Date exposing (..)
import Date.Extra.Core exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Model.Extra exposing (..)


type alias Model =
    { messages_url : Url
    , tasks_url : Url
    , activity_url : Url
    }


initialModel : Model
initialModel =
    { messages_url = ""
    , tasks_url = ""
    , activity_url = ""
    }


decode : Decoder Model
decode =
    Decode.map3 Model
        (field "messages_url" Decode.string)
        (field "tasks_url" Decode.string)
        (field "activity_url" Decode.string)
