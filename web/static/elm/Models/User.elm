module Models.User exposing (..)

import Date exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Models.Extra exposing (..)


type alias User =
    { avatar : String
    , name : String
    }


initialModel =
    { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000"
    , name = "hoge"
    }


encode : User -> Encode.Value
encode model =
    Encode.object
        [ ( "avatar", Encode.string model.avatar )
        , ( "name", Encode.string model.name )
        ]


decode : Decoder User
decode =
    Decode.object2 User
        ("avatar" := oneOf [ Decode.string, Decode.null "https://www.gravatar.com/avatar/00000000000000000000000000000000" ])
        ("name" := optional Decode.string "")


decodeList : Decoder (List User)
decodeList =
    Decode.list decode
