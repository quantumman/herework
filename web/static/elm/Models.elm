module Models exposing (..)

import CommentList.Model as CommentList exposing (..)
import Component.Error.Model as Error exposing (..)
import Date exposing (..)
import Date.Extra.Core exposing (..)
import DateTime.Model as DateTime exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Message.Model as MessageModel exposing (..)
import MessageList.Model as MessageList exposing (..)
import Models.App as App exposing (..)
import Models.Comment as Comment exposing (..)
import Models.Extra as Extra exposing (..)
import Models.Message as Message exposing (..)
import Models.User as User exposing (..)
import Monocle.Lens exposing (Lens, compose)
import Router.Model as Router exposing (..)


-- Appliation Model


type alias Model =
    { router : Router.Model
    , app : App.Model
    , user : User
    , error : Error.Model
    , now : DateTime.Model
    , commentList : CommentList.Model
    , messageList : MessageList.Model
    , message : MessageModel.Model
    }


initialModel : Router.Model -> Model
initialModel router =
    { router = router
    , app = App.initialModel
    , user = User.initialModel
    , error = Error.initialModel
    , now = DateTime.initialModel
    , commentList = CommentList.initialModel
    , messageList = MessageList.initialModel
    , message = MessageModel.initialModel
    }



-- RE-EXPORT


type alias Url =
    Extra.Url


type alias SelectableItem a =
    Extra.SelectableItem a
