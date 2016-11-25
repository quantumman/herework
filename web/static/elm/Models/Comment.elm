module Models.Comment exposing (..)

import Date exposing (..)
import Date.Extra.Core exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Models.User as User exposing (..)


type alias Comment =
    { id : Int
    , body : String
    , creator : User
    , created_at : Date
    }


encode : Comment -> Encode.Value
encode model =
    Encode.object
        [ ( "id", Encode.int model.id )
        , ( "body", Encode.string model.body )
        , ( "creator", User.encode model.creator )
        ]


decode : Decoder Comment
decode =
    Decode.map4 Comment
        (field "id" Decode.int)
        (field "body" Decode.string)
        (field "creator" User.decode)
        (field "created_at" Decode.date)


decodeList : Decoder (List Comment)
decodeList =
    Decode.list decode
