module Models exposing (..)

import Component.Error.Model as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (..)
import Date exposing (..)
import Date.Extra.Core exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Models.App as App exposing (..)
import Models.Comment as Comment exposing (..)
import Models.Extra as Extra exposing (..)
import Models.Message as Message exposing (..)
import Models.User as User exposing (..)
import Models.Views as Views exposing (..)
import Monocle.Lens exposing (Lens, compose)
import Router as Router exposing (..)


-- Appliation Model


type alias Model =
    { router : Router.Model
    , views : Views.Model
    , app : App.Model
    , user : User
    , messages : Resource Message
    , comments : List Comment
    , error : Error.Model
    , now : DateTime.Model
    }


initialModel : Router.Model -> Model
initialModel router =
    { router = router
    , views = Views.initialModel
    , app = App.initialModel
    , user = User.initialModel
    , messages =
        { list = []
        , entity = Message.initialModel
        }
    , comments = []
    , error = Error.initialModel
    , now = DateTime.initialModel
    }


type alias Resource m =
    { list : List m
    , entity : m
    }



-- RE-EXPORT


type alias Url =
    Extra.Url


type alias SelectableItem a =
    Extra.SelectableItem a



-- HELPER


messagesOfModel : Lens Model Views.MessagesView
messagesOfModel =
    compose viewsOfModel Views.messagesOfViews


viewsOfModel : Lens Model Views.Model
viewsOfModel =
    let
        get model =
            model.views

        set views model =
            { model | views = views }
    in
        Lens get set
