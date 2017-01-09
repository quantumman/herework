module App exposing (..)

import Commands as Commands exposing (..)
import CommentList.View.List as CommentList exposing (view)
import Component.Error.View as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (init)
import Component.UI.Attribute exposing (..)
import Component.UI.Columns as Columns exposing (..)
import Component.UI.Nav as Nav exposing (..)
import Component.Views.Messages as Messages exposing (view)
import FontAwesome.Web as Icon exposing (edit)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers exposing (..)
import List.Extra as List exposing (..)
import Message exposing (..)
import Message.View.Message as Message exposing (..)
import MessageList.View.List as MessageList exposing (..)
import Models as App exposing (Model)
import Models exposing (..)
import Models.User exposing (User)
import Navigation
import Router as Router exposing (Route(..), SubRoute(..))
import View.Toolbar as Toolbar exposing (..)


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
            [ Nav.tab [ activeAt messages model, navigateTo (Messages List) ] [ text "Mesasges" ]
            , Nav.tab [ activeAt tasks model, navigateTo Tasks ] [ text "Tasks" ]
            , Nav.tab [ activeAt activity model, navigateTo Activity ] [ text "Activtiy" ]
            , Nav.tab [] [ text "Setting" ]
            ]
        , div [ class "container" ]
            [ case model.router.route of
                Messages _ ->
                    Toolbar.view [ postMessage ]

                _ ->
                    div [] []
            , columns []
                [ column [ Eight, Offset Two ]
                    [ div [ box ]
                        [ div [ scrollable ]
                            [ case model.router.route of
                                Messages List ->
                                    MessageList.view model.messageList

                                Messages (Edit _) ->
                                    Message.view model.now model.message

                                Messages New ->
                                    Message.view model.now model.message

                                Messages (Show _) ->
                                    div []
                                        [ Message.view model.now model.message
                                        , CommentList.view model.now model.commentList
                                        ]

                                _ ->
                                    div [] []
                            ]
                        ]
                    ]
                ]
            ]
        ]


activeAt : Int -> App.Model -> Attribute Msg
activeAt id model =
    let
        currentId =
            case model.router.route of
                Messages _ ->
                    messages

                Tasks ->
                    tasks

                Activity ->
                    activity

                _ ->
                    other
    in
        if id == currentId then
            active
        else
            class ""


messages : Int
messages =
    0


tasks : Int
tasks =
    1


activity : Int
activity =
    2


other : Int
other =
    3


scrollable : Attribute Msg
scrollable =
    style
        [ ( "height", "75vh" )
        , ( "overflow", "auto" )
        ]
