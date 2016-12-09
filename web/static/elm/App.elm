module App exposing (..)

import Aui.Avatars exposing (..)
import Commands as Commands exposing (..)
import Component.Error.View as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (init)
import Component.UI.Attribute exposing (..)
import Component.UI.Columns as Columns exposing (..)
import Component.UI.Nav as Nav exposing (..)
import FontAwesome.Web as Icon exposing (edit)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models as App exposing (Model)
import Models exposing (..)
import Models.User exposing (User)
import Navigation
import Router as Router exposing (..)


-- MODEL


init : Router.Model -> ( App.Model, Cmd Msg )
init router =
    let
        ( _, dateTimeCommand ) =
            DateTime.init
    in
        (initialModel router) ! [ Commands.initApp "/api/app", Cmd.map Now dateTimeCommand ]



-- SUBSCRIPTION


subscriptions : App.Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : App.Model -> Html Msg
view model =
    div []
        []


scrollable : List (Html Msg) -> Html Msg
scrollable html =
    let
        wrapper =
            [ ( "position", "relative" )
            , ( "height", "auto" )
            ]

        innerWrapper =
            [ ( "height", "100%" ) ]
    in
        div [ style wrapper ]
            [ div []
                [ div [ style innerWrapper ] html
                ]
            ]
