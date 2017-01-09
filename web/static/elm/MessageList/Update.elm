module MessageList.Update exposing (..)

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


updateModel : MessageList.Msg -> MessageList.Model -> MessageList.Model
updateModel message model =
    case message of
        List ->
            model

        Fetch (Ok messages) ->
            { model | messages = messages }

        _ ->
            model


updateCommand : App.Msg -> App.Model -> Cmd App.Msg
updateCommand message model =
    Cmd.batch <|
        case message of
            MessageList List ->
                [ Cmd.map MessageList <| fetch model ]

            _ ->
                []



-- COMMADN


fetch : App.Model -> Cmd MessageList.Msg
fetch model =
    Commands.fetchMessages model.app.messages_url Fetch
