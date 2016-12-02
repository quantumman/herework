module Models exposing (..)

import Component.Error.Model as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (..)
import Component.UI.Editor as Editor exposing (Model, initialModel)
import Date exposing (..)
import Date.Extra.Core exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Models.Comment as Comment exposing (..)
import Models.Extra as Extra exposing (..)
import Models.Message as Message exposing (..)
import Models.Resource as Resource exposing (..)
import Models.User as User exposing (..)
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
    , now : DateTime.Model
    , editor : Editor.Model
    }


initialModel : Router.Model -> Model
initialModel router =
    { router = router
    , resource = initialModelResource
    , user = User.initialModel
    , messages = []
    , newMessage = Message.initialModel
    , selectedMessage = Nothing
    , comments = []
    , error = Error.initialModel
    , now = DateTime.initialModel
    , editor = Editor.initialModel
    }



-- RE-EXPORT


type alias Url =
    Extra.Url


type alias SelectableItem a =
    Extra.SelectableItem a
