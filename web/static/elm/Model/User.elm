module Model.User exposing (..)

import Date exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Model.Extra exposing (..)


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
    Decode.map2 User
        (field "avatar" <| oneOf [ Decode.string, Decode.null "https://www.gravatar.com/avatar/00000000000000000000000000000000" ])
        (field "name" <| optional Decode.string "")


decodeList : Decoder (List User)
decodeList =
    Decode.list decode
