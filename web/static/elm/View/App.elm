module View.App exposing (..)

import Command as Command exposing (..)
import CommentList.View.List as CommentList exposing (view)
import DateTime.View.DateTime as DateTime exposing (..)
import Error.View.Error as Error exposing (..)
import FontAwesome.Web as Icon exposing (edit)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import View.Attribute.Navigation exposing (..)
import List.Extra as List exposing (..)
import Msg as App exposing (..)
import Message.View.Message as Message exposing (..)
import MessageList.View.List as MessageList exposing (..)
import Model as App exposing (Model)
import Model exposing (..)
import Model.User exposing (User)
import Navigation
import Router.Model as Router exposing (..)
import Router.Msg as Router exposing (..)
import View.Toolbar as Toolbar exposing (..)
import View.UI.Attribute exposing (..)
import View.UI.Columns as Columns exposing (..)
import View.UI.Nav as Nav exposing (..)


-- VIEW


view : App.Model -> Html App.Msg
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


activeAt : Int -> App.Model -> Attribute App.Msg
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


scrollable : Attribute App.Msg
scrollable =
    style
        [ ( "height", "75vh" )
        , ( "overflow", "auto" )
        ]
