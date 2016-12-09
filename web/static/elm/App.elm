module App exposing (..)

import Aui.Avatars exposing (..)
import Commands as Commands exposing (..)
import Component.Error.View as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (init)
import Component.UI.Attribute exposing (..)
import Component.UI.Columns as Columns exposing (..)
import Component.UI.Nav as Nav exposing (..)
import Component.Views.MessageList as MessageList exposing (..)
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
        [ Nav.tabs
            [ Nav.tab (activeOnClick Messages model) [ text "Mesasges" ]
            , Nav.tab (activeOnClick Tasks model) [ text "Tasks" ]
            , Nav.tab (activeOnClick Activity model) [ text "Activtiy" ]
            , Nav.tab [] [ text "Setting" ]
            ]
        , div [ class "container" ]
            [ columns [ Desktop ]
                [ column [ Half ]
                    [ div [ box ]
                        [ div [ scrollable ]
                            [ case model.router.route of
                                Messages ->
                                    MessageList.view model

                                _ ->
                                    div [] []
                            ]
                        ]
                    ]
                , column [ Half ]
                    []
                ]
            ]
        ]


activeOnClick : Route -> App.Model -> List (Attribute msg)
activeOnClick route model =
    let
        active_ =
            if route == model.router.route then
                active
            else
                class ""
    in
        [ active_, href (reverse route) ]


scrollable : Attribute Msg
scrollable =
    style
        [ ( "height", "86vh" )
        , ( "overflow", "auto" )
        ]
