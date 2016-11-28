module Main exposing (..)

import App as App exposing (..)
import Commands as App exposing (..)
import Html exposing (Html)
import Message as App exposing (..)
import Models as App exposing (Model)
import Navigation exposing (..)
import Router as Router exposing (..)
import Update as App exposing (..)


type alias Model =
    App.Model


init : Location -> ( Model, Cmd Msg )
init location =
    let
        route =
            Router.urlParse location

        ( router, routerCommand ) =
            Router.init location

        ( model, appCommand ) =
            App.init router
    in
        { model | router = router } ! [ Cmd.map App App.now, routerCommand, Cmd.map App appCommand ]


type Msg
    = App App.Msg
    | Router Router.Route
    | NoOp


urlUpdate : Location -> Msg
urlUpdate location =
    case Router.urlParse location of
        Just route ->
            Router route

        Nothing ->
            NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        App subMessage ->
            let
                ( newModel, command ) =
                    App.update subMessage model
            in
                newModel ! [ Cmd.map App command ]

        Router route ->
            let
                router =
                    Router.update route model.router
            in
                { model | router = router } ! [ Cmd.map App App.now ]

        NoOp ->
            model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map App <| App.subscriptions model


view : Model -> Html Msg
view model =
    Html.map App <| App.view model


main : Program Never Model Msg
main =
    Navigation.program urlUpdate
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
