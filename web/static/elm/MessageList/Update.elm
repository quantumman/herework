module MessageList.Update exposing (..)

import Message as App exposing (Msg(..))
import MessageList.Model exposing (..)
import MessageList.Msg as MessageList exposing (..)


update : App.Msg -> Model -> Model
update message model =
    case message of
        MessageList msg ->
            updateModel msg model

        _ ->
            model


updateModel : MessageList.Msg -> Model -> Model
updateModel message model =
    case message of
        List ->
            model


updateCommand : App.Msg -> Model -> Cmd App.Msg
updateCommand message model =
    Cmd.batch <|
        case message of
            MessageList _ ->
                []

            _ ->
                []
