module Models.Resource exposing (..)

import Date exposing (..)
import Date.Extra.Core exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Models.Extra exposing (..)


type alias Resource =
    { messages_url : Url
    , tasks_url : Url
    , activity_url : Url
    }


initialModelResource =
    { messages_url = ""
    , tasks_url = ""
    , activity_url = ""
    }


decode : Decoder Resource
decode =
    Decode.object3 Resource
        ("messages_url" := Decode.string)
        ("tasks_url" := Decode.string)
        ("activity_url" := Decode.string)
