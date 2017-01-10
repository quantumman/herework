module Main exposing (..)

import App as App exposing (..)
import Commands as App exposing (initApp)
import DateTime.Update as DateTime exposing (getNow)
import Html exposing (Html)
import Message as App exposing (..)
import Models as App exposing (Model, initialModel)
import Navigation exposing (..)
import Router.Msg as Router exposing (Msg)
import Router.Update as Router exposing (urlUpdate, init)
import Update as App exposing (update)


init : Location -> ( App.Model, Cmd App.Msg )
init location =
    let
        ( router, routerCommand ) =
            Router.init location

        model =
            App.initialModel router
    in
        { model | router = router }
            ! [ Cmd.map Router routerCommand
              , DateTime.getNow
              , App.initApp "/api/app"
              ]


subscriptions : Model -> Sub App.Msg
subscriptions model =
    App.subscriptions model


view : Model -> Html App.Msg
view model =
    App.view model


main : Program Never Model App.Msg
main =
    Navigation.program urlUpdate
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
