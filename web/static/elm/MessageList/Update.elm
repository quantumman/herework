module MessageList.Update
    exposing
        ( update
        , command
        , fetch
        )

import Commands as Commands exposing (..)
import Message as App exposing (Msg(..))
import MessageList.Model as MessageList exposing (..)
import MessageList.Msg as MessageList exposing (..)
import Models as App exposing (..)


update : App.Msg -> MessageList.Model -> MessageList.Model
update message model =
    case message of
        MessageList msg ->
            updateModel msg model

        _ ->
            model


command : App.Msg -> App.Model -> Cmd App.Msg
command message model =
    case message of
        MessageList msg ->
            updateCommand msg model

        _ ->
            Cmd.none


updateModel : MessageList.Msg -> MessageList.Model -> MessageList.Model
updateModel message model =
    case message of
        List ->
            model

        Fetch (Ok messages) ->
            { model | messages = messages }

        _ ->
            model


updateCommand : MessageList.Msg -> App.Model -> Cmd App.Msg
updateCommand message model =
    Cmd.batch <|
        case message of
            List ->
                [ fetch model ]

            _ ->
                []



-- COMMADN


fetch : App.Model -> Cmd App.Msg
fetch { app } =
    Commands.fetchMessages app.messages_url Fetch
        |> Cmd.map MessageList
