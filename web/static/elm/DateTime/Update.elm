module DateTime.Update
    exposing
        ( update
        , command
        , getNow
        )

import Date
import DateTime.Model as DateTime exposing (..)
import DateTime.Msg as DateTime exposing (..)
import Message as App exposing (..)
import Models as App exposing (..)
import Task


update : App.Msg -> DateTime.Model -> DateTime.Model
update message model =
    case message of
        DateTime msg ->
            updateModel msg model

        _ ->
            model


command : App.Msg -> App.Model -> Cmd App.Msg
command message model =
    case message of
        DateTime msg ->
            updateCommand msg model

        _ ->
            Cmd.none


updateModel : DateTime.Msg -> DateTime.Model -> DateTime.Model
updateModel message model =
    case message of
        GetNow date ->
            { model | now = date }

        Fatal ->
            model


updateCommand : DateTime.Msg -> App.Model -> Cmd App.Msg
updateCommand message model =
    Cmd.batch <|
        case message of
            GetNow date ->
                []

            Fatal ->
                []



-- COMMAND


getNow : Cmd App.Msg
getNow =
    Task.perform GetNow Date.now
        |> Cmd.map DateTime
