module Main exposing (..)

import App as App exposing (..)
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Html exposing (Html)
import Html.App as Html exposing (..)
import Navigation
import Router as Router exposing (..)


type alias Model =
    App.Model


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init route =
    let
        ( router, routerCommand ) =
            Router.init route

        ( model, appCommand ) =
            App.init router
    in
        { model | router = router } ! [ Cmd.map Router routerCommand, Cmd.map App appCommand ]


type Msg
    = App App.Msg
    | Router Router.Route


urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate router model =
    ( { model | router = make router }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        App subMessage ->
            let
                ( model', command ) =
                    App.update subMessage model
            in
                model' ! [ Cmd.map App command ]

        Router route ->
            let
                ( router, command ) =
                    Router.update route model.router
            in
                { model | router = router } ! [ Cmd.map Router command ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map App <| App.subscriptions model


view : Model -> Html Msg
view model =
    Html.map App <| App.view model


main : Program Never
main =
    Navigation.program Router.urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
