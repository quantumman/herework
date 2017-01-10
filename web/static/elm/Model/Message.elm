module Model.Message exposing (..)

import Date exposing (..)
import Date.Extra.Core exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Model.User as User exposing (..)


type alias Message =
    { id : Int
    , title : String
    , body : String
    , url : String
    , comments_url : String
    , creator : User
    , created_at : Date
    }


initialModel =
    { id = -1
    , title = ""
    , body = ""
    , url = ""
    , comments_url = ""
    , creator = User.initialModel
    , created_at = Date.Extra.Core.fromTime 0
    }


encode : Message -> Encode.Value
encode model =
    Encode.object
        [ ( "message"
          , (Encode.object
                [ ( "title", Encode.string model.title )
                , ( "body", Encode.string model.body )
                ]
            )
          )
        ]


decode : Decoder Message
decode =
    Decode.map7 Message
        (field "id" Decode.int)
        (field "title" Decode.string)
        (field "body" Decode.string)
        (field "url" Decode.string)
        (field "comments_url" Decode.string)
        (field "creator" User.decode)
        (field "created_at" Decode.date)


decodeList : Decoder (List Message)
decodeList =
    Decode.list decode
