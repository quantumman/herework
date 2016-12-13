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
import HtmlHelpers exposing (..)
import Message exposing (..)
import Models as App exposing (Model)
import Models exposing (..)
import Models.User exposing (User)
import Navigation
import Router as Router exposing (Route(..))


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
            [ Nav.tab [ activeAt [ Messages ] model, navigateTo Messages ] [ text "Mesasges" ]
            , Nav.tab [ activeAt [ Tasks ] model, navigateTo Tasks ] [ text "Tasks" ]
            , Nav.tab [ activeAt [ Activity ] model, navigateTo Activity ] [ text "Activtiy" ]
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


activeAt : List Route -> App.Model -> Attribute msg
activeAt routes model =
    if List.member model.router.route routes then
        active
    else
        class ""


scrollable : Attribute Msg
scrollable =
    style
        [ ( "height", "86vh" )
        , ( "overflow", "auto" )
        ]
