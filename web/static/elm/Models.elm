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
    , error : Maybe String
    }


initialModel : Router.Model -> Model
initialModel router =
    { router = router
    , user = initialModelUser
    , messages =
        [ initialModelMessage
        , { title = "foobar", url = "messages/1" }
        , { title = "REQUEST: Working with BOT", url = "messages/2" }
        , { title = "QUESTION: How can we make issue ?", url = "messages/3" }
        ]
    , error = Nothing
    }



-- User


type alias User =
    { avatar : String
    }


initialModelUser =
    { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000"
    }



-- Message


type alias Message =
    { title : String
    , url : String
    }


initialModelMessage =
    { title = "test"
    , url = "issues/1"
    }


encodeMessage : Message -> Encode.Value
encodeMessage model =
    Encode.object
        [ ( "title", Encode.string model.title )
        , ( "url", Encode.string model.url )
        ]


decodeMessage : Decoder Message
decodeMessage =
    Decode.object2 Message
        ("title" := Decode.string)
        ("url" := Decode.string)


decodeMessages : Decoder (List Message)
decodeMessages =
    Decode.list decodeMessage
