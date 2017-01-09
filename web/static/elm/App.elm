module App exposing (..)

import Commands as Commands exposing (..)
import Component.Error.View as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (init)
import Component.UI.Attribute exposing (..)
import Component.UI.Columns as Columns exposing (..)
import Component.UI.Nav as Nav exposing (..)
import Component.Views.Messages as Messages exposing (view)
import Component.Views.Toolbar as Toolbar exposing (..)
import FontAwesome.Web as Icon exposing (edit)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers exposing (..)
import Message exposing (..)
import Message.View.Message as Message exposing (..)
import MessageList.View.List as MessageList exposing (..)
import Models as App exposing (Model)
import Models exposing (..)
import Models.User exposing (User)
import Navigation
import Router as Router exposing (Route(..), SubRoute(..))


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
            [ Nav.tab [ activeAt model (messages model), navigateTo (Messages List) ] [ text "Mesasges" ]
            , Nav.tab [ activeAt model [ Tasks ], navigateTo Tasks ] [ text "Tasks" ]
            , Nav.tab [ activeAt model [ Activity ], navigateTo Activity ] [ text "Activtiy" ]
            , Nav.tab [] [ text "Setting" ]
            ]
        , div [ class "container" ]
            [ Toolbar.view model
            , columns []
                [ column [ Eight, Offset Two ]
                    [ div [ box ]
                        [ div [ scrollable ]
                            [ case model.router.route of
                                Messages List ->
                                    MessageList.view model.messageList

                                Messages (Edit _) ->
                                    Message.view model.message

                                Messages New ->
                                    Message.view model.message

                                Messages (Show _) ->
                                    Message.view model.message

                                _ ->
                                    div [] []
                            ]
                        ]
                    ]
                ]
            ]
        ]


activeAt : App.Model -> List Route -> Attribute Msg
activeAt model routes =
    if List.member model.router.route routes then
        active
    else
        class ""


messages : App.Model -> List Route
messages model =
    let
        messageRoutes =
            [ Messages List, Messages New ]
    in
        model.messages.entity.id
            |> (\id -> messageRoutes ++ [ Messages <| Show id, Messages <| Edit id ])


scrollable : Attribute Msg
scrollable =
    style
        [ ( "height", "75vh" )
        , ( "overflow", "auto" )
        ]
