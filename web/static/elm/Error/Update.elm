module Error.Update
    exposing
        ( update
        , command
        , show
        )

import Error.Msg as Error exposing (..)
import Error.Model as Error exposing (..)
import Http as Http exposing (..)
import Message as App exposing (..)
import Models as App exposing (..)
import Task


update : App.Msg -> Error.Model -> Error.Model
update message model =
    case message of
        Error msg ->
            updateModel msg model

        _ ->
            model


command : App.Msg -> App.Model -> Cmd App.Msg
command message model =
    case message of
        Error msg ->
            updateCommand msg model

        _ ->
            Cmd.none


updateModel : Error.Msg -> Error.Model -> Error.Model
updateModel message model =
    case message of
        Http e ->
            { model | error = Just (httpErrorAsString e) }

        Close ->
            { model | error = Nothing }


updateCommand : Error.Msg -> App.Model -> Cmd App.Msg
updateCommand message model =
    case message of
        _ ->
            Cmd.none



-- HELPER


httpErrorAsString : Http.Error -> String
httpErrorAsString e =
    case e of
        Http.BadUrl url ->
            "Bad url " ++ url

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "Network has troubles. Try it later"

        Http.BadStatus response ->
            response.status.message

        Http.BadPayload payload response ->
            payload



-- COMMAND


show : Http.Error -> Cmd App.Msg
show e =
    Task.succeed e
        |> Task.perform Http
        |> Cmd.map App.Error
