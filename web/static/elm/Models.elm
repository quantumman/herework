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
    , resource : Resource
    , user : User
    , messages : List Message
    , selectedMessage : Message
    , comments : List Comment
    , error : Maybe String
    }


initialModel : Router.Model -> Model
initialModel router =
    { router = router
    , resource = initialModelResource
    , user = initialModelUser
    , messages =
        [ initialModelMessage
        , { id = 1, title = "foobar", url = "messages/1", comments_url = "foobar", creator = initialModelUser }
        , { id = 2, title = "REQUEST: Working with BOT", url = "messages/2", comments_url = "foobar", creator = initialModelUser }
        , { id = 3, title = "QUESTION: How can we make issue ?", url = "messages/3", comments_url = "foboar", creator = initialModelUser }
        ]
    , selectedMessage = initialModelMessage
    , comments = []
    , error = Nothing
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
    , comments_url : String
    , creator : User
    }


initialModelMessage =
    { id = 0
    , title = "test"
    , url = "issues/1"
    , comments_url = "/api/messages/0/comments"
    , creator = initialModelUser
    }


encodeMessage : Message -> Encode.Value
encodeMessage model =
    Encode.object
        [ ( "id", Encode.int model.id )
        , ( "title", Encode.string model.title )
        , ( "url", Encode.string model.url )
        , ( "comments_url", Encode.string model.comments_url )
        , ( "creator", encodeUser model.creator )
        ]


decodeMessage : Decoder Message
decodeMessage =
    Decode.object5 Message
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("url" := Decode.string)
        ("comments_url" := Decode.string)
        ("creator" := decodeUser)


decodeMessages : Decoder (List Message)
decodeMessages =
    Decode.list decodeMessage



-- Comment


type alias Comment =
    { id : Int
    , body : String
    , user : User
    }


encodeComment : Comment -> Encode.Value
encodeComment model =
    Encode.object
        [ ( "id", Encode.int model.id )
        , ( "body", Encode.string model.body )
        , ( "user", encodeUser model.user )
        ]


decodeComment : Decoder Comment
decodeComment =
    Decode.object3 Comment
        ("id" := Decode.int)
        ("body" := Decode.string)
        ("user" := decodeUser)


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
