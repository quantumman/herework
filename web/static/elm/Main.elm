module Main exposing (..)

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Html exposing (Html, div, text)
import Navigation
import Router as Router exposing (..)


type alias Model =
    { router : Router.Model }


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init route =
    let
        ( router, command ) =
            Router.init route
    in
        { router = router } ! [ Cmd.map Router command ]


type Msg
    = Router Router.Route


urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate router model =
    ( { model | router = make router }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Router route ->
            let
                ( router, command ) =
                    Router.update route model.router
            in
                { model | router = router } ! [ Cmd.map Router command ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div [] [ text "Hello World" ]


main : Program Never
main =
    Navigation.program Router.urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
