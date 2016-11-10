module Models exposing (..)

import Component.DateTime as DateTime exposing (..)
import Component.Error.Model as Error exposing (..)
import Date exposing (..)
import Date.Extra.Core exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Router as Router exposing (..)


-- Appliation Model


type alias Model =
    { router : Router.Model
    , resource : Resource
    , user : User
    , messages : List Message
    , newMessage : Message
    , selectedMessage : Maybe Message
    , comments : List Comment
    , error : Error.Model
    , dateTime : DateTime.Model
    }


initialModel : Router.Model -> Model
initialModel router =
    { router = router
    , resource = initialModelResource
    , user = initialModelUser
    , messages = []
    , newMessage = initialModelMessage
    , selectedMessage = Nothing
    , comments = []
    , error = Error.initialModel
    , dateTime = DateTime.initialModel
    }



-- Resoruce


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


decodeResource : Decoder Resource
decodeResource =
    Decode.object3 Resource
        ("messages_url" := Decode.string)
        ("tasks_url" := Decode.string)
        ("activity_url" := Decode.string)



-- User


type alias User =
    { avatar : String
    , name : String
    }


initialModelUser =
    { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000"
    , name = "hoge"
    }


encodeUser : User -> Encode.Value
encodeUser model =
    Encode.object
        [ ( "avatar", Encode.string model.avatar )
        , ( "name", Encode.string model.name )
        ]


decodeUser : Decoder User
decodeUser =
    Decode.object2 User
        ("avatar" := oneOf [ Decode.string, Decode.null "https://www.gravatar.com/avatar/00000000000000000000000000000000" ])
        ("name" := optional Decode.string "")


decodeUsers : Decoder (List User)
decodeUsers =
    Decode.list decodeUser



-- Message


type alias Message =
    { id : Int
    , title : String
    , body : String
    , url : String
    , comments_url : String
    , creator : User
    , created_at : Date
    }


initialModelMessage =
    { id = 0
    , title = ""
    , body = ""
    , url = ""
    , comments_url = ""
    , creator = initialModelUser
    , created_at = Date.Extra.Core.fromTime 0
    }


encodeMessage : Message -> Encode.Value
encodeMessage model =
    Encode.object
        [ ( "message"
          , (Encode.object
                [ ( "title", Encode.string model.title )
                , ( "body", Encode.string model.body )
                ]
            )
          )
        ]


decodeMessage : Decoder Message
decodeMessage =
    Decode.object7 Message
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("body" := Decode.string)
        ("url" := Decode.string)
        ("comments_url" := Decode.string)
        ("creator" := decodeUser)
        ("created_at" := Decode.date)


decodeMessages : Decoder (List Message)
decodeMessages =
    Decode.list decodeMessage



-- Comment


type alias Comment =
    { id : Int
    , body : String
    , creator : User
    , created_at : Date
    }


encodeComment : Comment -> Encode.Value
encodeComment model =
    Encode.object
        [ ( "id", Encode.int model.id )
        , ( "body", Encode.string model.body )
        , ( "creator", encodeUser model.creator )
        ]


decodeComment : Decoder Comment
decodeComment =
    Decode.object4 Comment
        ("id" := Decode.int)
        ("body" := Decode.string)
        ("creator" := decodeUser)
        ("created_at" := Decode.date)


decodeComments : Decoder (List Comment)
decodeComments =
    Decode.list decodeComment



-- MISC


type alias Url =
    String


type alias SelectableItem a =
    { selected : Bool
    , item : a
    }



-- HELPER


optional : Decoder a -> a -> Decoder a
optional decoder defaultValue =
    oneOf
        [ decoder
        , Decode.null defaultValue
        ]
