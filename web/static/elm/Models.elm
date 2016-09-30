module Models exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Router as Router exposing (..)


-- Appliation Model


type alias Model =
    { router : Router.Model
    , user : User
    , messages : List Message
    , selectedMessage : Message
    , comments : List Comment
    , error : Maybe String
    }


initialModel : Router.Model -> Model
initialModel router =
    { router = router
    , user = initialModelUser
    , messages =
        [ initialModelMessage
        , { id = 1, title = "foobar", url = "messages/1" }
        , { id = 2, title = "REQUEST: Working with BOT", url = "messages/2" }
        , { id = 3, title = "QUESTION: How can we make issue ?", url = "messages/3" }
        ]
    , selectedMessage = initialModelMessage
    , comments = []
    , error = Nothing
    }



-- User


type alias User =
    { avatar : String
    }


initialModelUser =
    { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000"
    }


encodeUser : User -> Encode.Value
encodeUser model =
    Encode.object
        [ ( "avatar", Encode.string model.avatar )
        ]


decodeUser : Decoder User
decodeUser =
    Decode.object1 User
        ("avatar" := Decode.string)


decodeUsers : Decoder (List User)
decodeUsers =
    Decode.list decodeUser



-- Message


type alias Message =
    { id : Int
    , title : String
    , url : String
    }


initialModelMessage =
    { id = 0
    , title = "test"
    , url = "issues/1"
    }


encodeMessage : Message -> Encode.Value
encodeMessage model =
    Encode.object
        [ ( "id", Encode.int model.id )
        , ( "title", Encode.string model.title )
        , ( "url", Encode.string model.url )
        ]


decodeMessage : Decoder Message
decodeMessage =
    Decode.object3 Message
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("url" := Decode.string)


decodeMessages : Decoder (List Message)
decodeMessages =
    Decode.list decodeMessage



-- Comment


type alias Comment =
    { id : Int
    , body : String
    , user : User
    }



-- MISC


type alias Url =
    String


type alias SelectableItem a =
    { selected : Bool
    , item : a
    }
