module App.Update
    exposing
        ( update
        , command
        )

import App.Model as Self exposing (..)
import App.Msg as Self exposing (..)
import Model as App exposing (..)
import Msg as App exposing (..)


update : App.Msg -> Self.Model m -> Self.Model m
update message model =
    case message of
        App msg ->
            updateModel msg model

        _ ->
            model


command : App.Msg -> App.Model -> Cmd App.Msg
command message model =
    case message of
        _ ->
            Cmd.none


updateModel : Self.Msg -> Self.Model m -> Self.Model m
updateModel message model =
    case message of
        FetchResource (Ok app) ->
            { model | app = app }

        _ ->
            model
