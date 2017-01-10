module Control.Update
    exposing
        ( update
        , command
        )

import Control.Msg as Control exposing (..)
import Model as App exposing (..)
import Msg as App exposing (..)
import Router.Command as Router exposing (navigateTo)


update : App.Msg -> App.Model -> App.Model
update message model =
    case message of
        _ ->
            model


command : App.Msg -> App.Model -> Cmd App.Msg
command message model =
    case message of
        Control msg ->
            updateCommand msg model

        _ ->
            Cmd.none


updateCommand : Control.Msg -> App.Model -> Cmd App.Msg
updateCommand message model =
    case message of
        NavigateTo route ->
            Router.navigateTo route
